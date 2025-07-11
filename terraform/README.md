# EKS 3-Tier Voting Application

هذا المشروع ينشر تطبيق تصويت ثلاثي الطبقات على Amazon EKS باستخدام Terraform.

## البنية المعمارية

- **Frontend**: React application
- **Backend**: Node.js API
- **Database**: PostgreSQL
- **Infrastructure**: AWS EKS with ALB Ingress Controller

## المتطلبات المسبقة

1. AWS CLI مُكوّن
2. kubectl مُثبّت
3. Terraform مُثبّت
4. Helm مُثبّت
5. صلاحيات AWS مناسبة

## خطوات النشر

### 1. إعداد المتغيرات

```bash
cp terraform.tfvars.example terraform.tfvars
# قم بتعديل القيم حسب احتياجاتك
```

### 2. تشغيل Terraform

```bash
# تهيئة Terraform
terraform init

# مراجعة الخطة
terraform plan

# تطبيق التغييرات
terraform apply
```

### 3. تثبيت الخدمات الإضافية

```bash
# تشغيل السكريبت لتثبيت ALB Controller و EBS CSI Driver
chmod +x script.sh
./script.sh
```

## التحقق من النشر

```bash
# التحقق من حالة الـ pods
kubectl get pods

# التحقق من الخدمات
kubectl get services

# التحقق من الـ Ingress
kubectl get ingress

# الحصول على URL التطبيق
kubectl get ingress voting-ingress -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'
```

## الأوامر المفيدة

```bash
# عرض logs الـ backend
kubectl logs -l app=backend

# عرض logs الـ frontend
kubectl logs -l app=frontend

# عرض logs قاعدة البيانات
kubectl logs -l app=postgres

# الدخول إلى pod معين
kubectl exec -it <pod-name> -- /bin/bash

# إعادة تشغيل deployment
kubectl rollout restart deployment/backend
kubectl rollout restart deployment/frontend
```

## تنظيف الموارد

```bash
# حذف التطبيق
kubectl delete -f all-file-copy.yaml

# حذف البنية التحتية
terraform destroy
```

## استكشاف الأخطاء

### مشاكل شائعة:

1. **Pods في حالة Pending**: تحقق من Node capacity
2. **ALB لا يعمل**: تحقق من IAM roles والـ security groups
3. **Database connection issues**: تحقق من الـ service names والـ ports

### فحص الـ logs:

```bash
# فحص events الكلاستر
kubectl get events --sort-by=.metadata.creationTimestamp

# فحص وصف pod معين
kubectl describe pod <pod-name>

# فحص logs الـ ALB Controller
kubectl logs -n kube-system deployment/aws-load-balancer-controller
```

## الملفات المهمة

- `variables.tf`: تعريف المتغيرات
- `outputs.tf`: المخرجات
- `script.sh`: سكريبت تثبيت الخدمات
- `all-file-copy.yaml`: ملف Kubernetes manifests
- `terraform.tfvars.example`: مثال على ملف المتغيرات