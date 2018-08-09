From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v8 20/22] KVM: s390: Handling of Cypto control block in
 VSIE
Date: Thu, 9 Aug 2018 09:33:06 +0200
Message-ID: <a8f0c2f2-6e4c-3a06-0f89-aea3fcc0b985@linux.ibm.com>
References: <1533739472-7172-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1533739472-7172-21-git-send-email-akrowiak@linux.vnet.ibm.com>
 <dc8b3e66-9ba4-2b78-1e49-12a35d5d234b@linux.ibm.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <dc8b3e66-9ba4-2b78-1e49-12a35d5d234b@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 09/08/2018 08:20, Janosch Frank wrote:
> On 08.08.2018 16:44, Tony Krowiak wrote:
>> From: Pierre Morel <pmorel@linux.ibm.com>
>> +#define ECA_APIE 0x00000008
> That shouldn't be necessary, it's defined in kvm_host.h which vsie.c
> includes. Or is it not?

This was forgotten here for a long long time!
You are right I remove it.

>
>> +static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>> +{
>> +	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
>> +	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
>> +	const uint32_t crycbd_o = READ_ONCE(scb_o->crycbd);
>> +	const u32 crycb_addr = crycbd_o & 0x7ffffff8U;
>> +	int g2_fmt = vcpu->arch.sie_block->crycbd & CRYCB_FORMAT_MASK;
>> +	int g3_fmt = crycbd_o & CRYCB_FORMAT_MASK;
>> +	int g2_apie, g2_msa3, g3_apie, g3_msa3;
>> +	int size, ret;
>> +
>> +	/* crycb should not cross a page boundary */
>> +	size = (g3_fmt == CRYCB_FORMAT2) ? 0x100 : 0x80;
>> +	if ((crycb_addr & PAGE_MASK) != ((crycb_addr + size) & PAGE_MASK))
>> +		return set_validity_icpt(scb_s, 0x003CU);
>> +
>> +	g2_apie = vcpu->arch.sie_block->eca & ECA_APIE;
>> +	g3_apie = scb_o->eca & g2_apie;
>> +
>> +	g2_msa3 = test_kvm_facility(vcpu->kvm, 76);
>> +	g3_msa3 = (g3_fmt != CRYCB_FORMAT0) & g2_msa3;
>> +
>> +	scb_s->crycbd = 0;
>> +	/* If no AP instructions and no keys we just set crycbd to 0 */
>> +	if (!(g3_apie || g3_msa3))
>> +		return 0;
>> +
>> +	if (!crycb_addr)
>> +		return set_validity_icpt(scb_s, 0x0039U);
>> +
>> +	if (g3_apie) {
>> +		ret = copy_apcb(vcpu, vsie_page, g2_fmt, g3_fmt);
>> +		if (ret)
>> +			goto out;
> s/goto out;/return ret;/

better

Thanks

Pierre

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
