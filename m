From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v10 11/26] s390: vfio-ap: implement mediated device open
 callback
Date: Fri, 21 Sep 2018 19:28:20 -0400
Message-ID: <e1ff9918-a1ab-31b1-0b32-a3980770d2ac@linux.ibm.com>
References: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1536781396-13601-12-git-send-email-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1536781396-13601-12-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 09/12/2018 03:43 PM, Tony Krowiak wrote:
> From: Tony Krowiak <akrowiak@linux.ibm.com>
> 
> Implements the open callback on the mediated matrix device.
> The function registers a group notifier to receive notification
> of the VFIO_GROUP_NOTIFY_SET_KVM event. When notified,
> the vfio_ap device driver will get access to the guest's
> kvm structure. The open callback must ensure that only one
> mediated device shall be opened per guest.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Acked-by: Halil Pasic <pasic@linux.ibm.com>
> Tested-by: Michael Mueller <mimu@linux.ibm.com>
> Tested-by: Farhan Ali <alifm@linux.ibm.com>
> Tested-by: Pierre Morel <pmorel@linux.ibm.com>
> Acked-by: Pierre Morel <pmorel@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>   arch/s390/include/asm/kvm_host.h      |    1 +
>   drivers/s390/crypto/vfio_ap_ops.c     |  168 +++++++++++++++++++++++++++++++++
>   drivers/s390/crypto/vfio_ap_private.h |    5 +
>   3 files changed, 174 insertions(+), 0 deletions(-)
> 

(...)

> @@ -699,12 +730,149 @@ static ssize_t matrix_show(struct device *dev, struct device_attribute *attr,
>   	NULL
>   };
>   
> +/**
> + * Verify that the AP instructions are available on the guest. This is indicated
> + * via the  KVM_S390_VM_CPU_FEAT_AP CPU model feature.
> + */
> +static int kvm_ap_validate_crypto_setup(struct kvm *kvm)
> +{
> +	if (test_bit_inv(KVM_S390_VM_CPU_FEAT_AP, kvm->arch.cpu_feat))
> +		return 0;
> +
> +	return -EOPNOTSUPP;
> +}
> +

(...)

> +
> +/**
> + * vfio_ap_mdev_open_once
> + *
> + * @matrix_mdev: a mediated matrix device
> + *
> + * Return 0 if no other mediated matrix device has been opened for the
> + * KVM guest assigned to @matrix_mdev; otherwise, returns an error.
> + */
> +static int vfio_ap_mdev_open_once(struct ap_matrix_mdev *matrix_mdev,
> +				  struct kvm *kvm)
> +{
> +	struct ap_matrix_mdev *m;
> +
> +	mutex_lock(&matrix_dev->lock);
> +
> +	list_for_each_entry(m, &matrix_dev->mdev_list, node) {
> +		if ((m != matrix_mdev) && (m->kvm == kvm)) {
> +			mutex_unlock(&matrix_dev->lock);
> +			return -EPERM;
> +		}
> +	}
> +
> +	mutex_unlock(&matrix_dev->lock);
> +
> +	return 0;
> +}
> +
> +static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
> +				       unsigned long action, void *data)
> +{
> +	int ret;
> +	struct ap_matrix_mdev *matrix_mdev;
> +
> +	if (action != VFIO_GROUP_NOTIFY_SET_KVM)
> +		return NOTIFY_OK;
> +
> +	matrix_mdev = container_of(nb, struct ap_matrix_mdev, group_notifier);
> +
> +	if (!data) {
> +		matrix_mdev->kvm = NULL;
> +		return NOTIFY_OK;
> +	}
> +
> +	ret = vfio_ap_mdev_open_once(matrix_mdev, data);
> +	if (ret)
> +		return NOTIFY_DONE;
> +
> +	matrix_mdev->kvm = data;
> +
> +	ret = kvm_ap_validate_crypto_setup(matrix_mdev->kvm);
> +	if (ret)
> +		return ret;
> +
> +	vfio_ap_mdev_copy_masks(matrix_mdev);
> +
> +	return NOTIFY_OK;
> +}
> +
> +static int vfio_ap_mdev_open(struct mdev_device *mdev)
> +{
> +	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
> +	unsigned long events;
> +	int ret;
> +
> +
> +	if (!try_module_get(THIS_MODULE))
> +		return -ENODEV;
> +
> +	matrix_mdev->group_notifier.notifier_call = vfio_ap_mdev_group_notifier;
> +	events = VFIO_GROUP_NOTIFY_SET_KVM;
> +
> +	ret = vfio_register_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
> +				     &events, &matrix_mdev->group_notifier);
> +	if (ret) {
> +		module_put(THIS_MODULE);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +

(...)

The fixup! patch below modifies this patch (11/26) to illustrate how
David's recommendation will be implemented for v11 of the series. It
is one of three fixup! patches (the other two are in responses to
03/26 and 25/26) included to generate discussion in v10 rather than
waiting until v11 for comments.

-----------------------------------8<-----------------------------------

From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Thu, 20 Sep 2018 12:01:53 -0400
Subject: [FIXUP v10] fixup!: s390: vfio-ap: implement mediated device 
open callback

* Fix race condition in KVM notifier
* Remove test for KVM_S390_VM_CPU_FEAT_AP
---
  drivers/s390/crypto/vfio_ap_ops.c |   26 +++++++++++++++-----------
  1 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c 
b/drivers/s390/crypto/vfio_ap_ops.c
index 8bc0cdd..573a5cc 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -731,12 +731,12 @@ static ssize_t matrix_show(struct device *dev, 
struct device_attribute *attr,
  };

  /**
- * Verify that the AP instructions are available on the guest. This is 
indicated
- * via the  KVM_S390_VM_CPU_FEAT_AP CPU model feature.
+ * Verify that the AP instructions are being interpreted by firmware 
for the
+ * guest. This is indicated by the kvm->arch.crypto.apie flag.
   */
  static int kvm_ap_validate_crypto_setup(struct kvm *kvm)
  {
-	if (test_bit_inv(KVM_S390_VM_CPU_FEAT_AP, kvm->arch.cpu_feat))
+	if (kvm->arch.crypto.apie)
  		return 0;

  	return -EOPNOTSUPP;
@@ -772,15 +772,19 @@ static void vfio_ap_mdev_copy_masks(struct 
ap_matrix_mdev *matrix_mdev)
  }

  /**
- * vfio_ap_mdev_open_once
+ * vfio_ap_mdev_set_kvm
   *
   * @matrix_mdev: a mediated matrix device
+ * @kvm: reference to KVM instance
   *
- * Return 0 if no other mediated matrix device has been opened for the
- * KVM guest assigned to @matrix_mdev; otherwise, returns an error.
+ * Verifies no other mediated matrix device has a reference to @kvm and 
sets a
+ * reference to it in @matrix_mdev->kvm.
+ *
+ * Return 0 if no other mediated matrix device has a reference to @kvm;
+ * otherwise, returns -EPERM.
   */
-static int vfio_ap_mdev_open_once(struct ap_matrix_mdev *matrix_mdev,
-				  struct kvm *kvm)
+static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
+				struct kvm *kvm)
  {
  	struct ap_matrix_mdev *m;

@@ -793,6 +797,7 @@ static int vfio_ap_mdev_open_once(struct 
ap_matrix_mdev *matrix_mdev,
  		}
  	}

+	matrix_mdev->kvm = kvm;
  	mutex_unlock(&matrix_dev->lock);

  	return 0;
@@ -814,16 +819,15 @@ static int vfio_ap_mdev_group_notifier(struct 
notifier_block *nb,
  		return NOTIFY_OK;
  	}

-	ret = vfio_ap_mdev_open_once(matrix_mdev, data);
+	ret = vfio_ap_mdev_set_kvm(matrix_mdev, data);
  	if (ret)
  		return NOTIFY_DONE;

-	matrix_mdev->kvm = data;
-
  	ret = kvm_ap_validate_crypto_setup(matrix_mdev->kvm);
  	if (ret)
  		return ret;

+
  	vfio_ap_mdev_copy_masks(matrix_mdev);

  	return NOTIFY_OK;
-- 
1.7.1
