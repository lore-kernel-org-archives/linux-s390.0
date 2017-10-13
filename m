From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [RFC 17/19] KVM: s390: validate input to AP matrix config interface
Date: Fri, 13 Oct 2017 13:39:02 -0400
Message-ID: <1507916344-3896-18-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1507916344-3896-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1507916344-3896-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, Tony Krowiak <akrowiak@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Verifies that the AP matrix assigned to the KVM guest is
not shared by any other KVM guest running on the same
system.

The Crypto Control Block referenced by a KVM guest's SIE
state description contains two bit mask fields that identify
the AP adapters and usage domains to assigned to the
guest: The AP Matrix (APM) identifies the AP adapters assigned
to the KVM guest; and the AP Queue Matrix (AQM) identifies
the usage domains assigned to the KVM guest. Each adapter and
usage domain is identified by a number from 0 to 255. The
bits in each mask, from left to right, correspond to the
numbers 0-255. When a bit is set, the corresponding adapter
or usage domain is assigned to the KVM guest.

AP instructions identify the AP device to use to perform the
cryptographic function contained in the instruction's
payload. The AP device is identified by and AP Queue
Number (APQN). The APQN is comprised of two fields: The
AP Identifier (APID) that specifies an adapter ID; and
an AP Queue Identifier (APQI) that specifies a domain ID.

The bits in the APM and AQM fields of the KVM guest's CRYCB
specify the list of APQNs that are valid for instructions
submitted from the KVM guest. When an AP instruction is
executed by the KVM guest, if the bit in the APM corresponding
to the APID contained in the APQN specified in the AP
instruction is not set, the instruction will fail. Likewise,
if the bit in the AQM corresponding to the APQI contained in
the APQN specified in the AP instruction is not set, the
instruction will fail.

The APQNs that can be derived from the bits set in the
APM and AQM fields of the KVM guest's CRYCB must not be
available to any other KVM guest running on the same
system. If any APQN is not unique to the KVM guest,
the ioctl will fail.

Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
---
 arch/s390/kvm/ap-config.c |   71 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/arch/s390/kvm/ap-config.c b/arch/s390/kvm/ap-config.c
index dc79798..4b0794d 100644
--- a/arch/s390/kvm/ap-config.c
+++ b/arch/s390/kvm/ap-config.c
@@ -138,6 +138,73 @@ static int ap_config_get_emasks(struct ap_config_masks *masks)
 	return 0;
 }
 
+static unsigned long ap_config_get_num_mask_bits(struct kvm *kvm)
+{
+	return is_format2_crycb(kvm) ? sizeof(u64) * APCB1_MASK_SIZE * 8 :
+				       sizeof(u64) * APCB0_MASK_SIZE * 8;
+}
+
+static int ap_config_validate_queue(struct kvm *kvm, unsigned long apid,
+				    unsigned long apqi)
+{
+	int ret = 0;
+	struct kvm *vm;
+	u64 *mask;
+
+	mutex_lock(&kvm->lock);
+
+	/* No other VM may share an AP Queue with the input VM */
+	list_for_each_entry(vm, &vm_list, vm_list) {
+		if (kvm == vm)
+			continue;
+
+		mask = ap_config_get_crycb_apm(vm);
+		if (!test_bit_inv(apid, (unsigned long *)mask))
+			continue;
+
+		mask = ap_config_get_crycb_aqm(vm);
+		if (!test_bit_inv(apqi, (unsigned long *)mask))
+			continue;
+
+		pr_err("%s: AP queue %02lx.%04lx is already registered to %s",
+		       __func__, apid, apqi, kvm->arch.dbf->name);
+		ret = -EBUSY;
+
+		goto done;
+	}
+
+done:
+	mutex_unlock(&kvm->lock);
+	return ret;
+}
+
+static int ap_config_validate_queues(struct kvm *kvm,
+				     struct ap_config_masks *masks)
+{
+	int ret;
+	const unsigned long *apm = (unsigned long *)masks->apm;
+	const unsigned long *aqm = (unsigned long *)masks->aqm;
+	unsigned long nbits = ap_config_get_num_mask_bits(kvm);
+	unsigned long apid;
+	unsigned long apqi;
+
+	apid = find_first_bit_inv(apm, nbits);
+	while (apid < nbits) {
+		apqi = find_first_bit_inv(aqm, nbits);
+		while (apqi < nbits) {
+			ret = ap_config_validate_queue(kvm, apid, apqi);
+			if (ret)
+				return ret;
+
+			apqi = find_next_bit_inv(aqm, nbits, apqi + 1);
+		}
+
+		apid = find_next_bit_inv(apm, nbits, apid + 1);
+	}
+
+	return 0;
+}
+
 int ap_config_matrix(struct kvm *kvm, struct ap_config_masks *masks)
 {
 	int ret;
@@ -146,6 +213,10 @@ int ap_config_matrix(struct kvm *kvm, struct ap_config_masks *masks)
 	if (ret)
 		return ret;
 
+	ret = ap_config_validate_queues(kvm, masks);
+	if (ret)
+		return ret;
+
 	ap_config_set_crycb_masks(kvm, masks);
 
 	return 0;
-- 
1.7.1
