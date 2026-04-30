Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B66722D792;
	Thu, 30 Apr 2026 20:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777579832; cv=none; b=Wdq5zuRFPJ4WrMa6mPlv7T416JswXomM6TjdBZ7o7wE9Gz098jKtVNsMA3ms07lx8YoPNryZjlJea0KKLeAiGQb9DcHM3niEInEi5gOYh0+3VJUleXBddQn6w0Vj3EGVQLTVMHnfaHbH/o474cV5+qT8O1xfi5xSIQuSI46UtSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777579832; c=relaxed/simple;
	bh=gxuSPtmLmBpqbKyGomi2UOJJfv43nvtVyFqDmqrxvpg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=URDYhaPSEfQTp3dIb70UK9zCqccuTGPERrw1Is/NpduW/Jg7AFmuuHNvVD7Puec7f22WhELNLnoHDhneposxOcgXv68NCRgPvNMuxGfFekBEQPuExh3FJlu4svhkhVoM9ViyDhMo9ZJCPmekuQy3Z+DwgPVB7dN/ROw76dNemks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KDxMNFvX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KDxMNFvX"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63UJCagg2551013;
	Thu, 30 Apr 2026 20:10:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Nrph3+
	/Pm4Q+a85zXMkTERYfzpBrrROzrvG+qF/Cyk4=; b=KDxMNFvXxPR6OE05SaksY6
	ED9cYV/5Be8FWoNZNnB+2cM1wdg/5uyGbD/bo4wpyMItJ1ml/YCugIa8jCRBVFzS
	Uu+TFHhRVu5VaXDq2lnRs7qKcBpUQ8d1za556ZMT1Hv25EWec1Ng2v4B1+3Cci/G
	pH0HseAuiMz5uNxY80AW95LYiFB+H9oIKz6bX7Kb/9Y471XKJfJNa61lN+luU10Q
	NuHyFZdsfthUTqcNOHeegvwE0KmkvSzv/t2Lyu8DJge6JsbGvEYZqr5VEWUuqVNo
	1OnrZOVoRNsRyLIcRuxZKW8fevh8C0nFp1rL1qJG1IRmYV9h16gS9VGuPN2tptAg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drm1e7xuw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 20:10:21 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63UJs5P0017185;
	Thu, 30 Apr 2026 20:10:20 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsa5gmg93-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 20:10:20 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63UKAJNE12321320
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Apr 2026 20:10:19 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BBF0A58058;
	Thu, 30 Apr 2026 20:10:19 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 011A458057;
	Thu, 30 Apr 2026 20:10:19 +0000 (GMT)
Received: from [9.61.22.161] (unknown [9.61.22.161])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Apr 2026 20:10:18 +0000 (GMT)
Message-ID: <c2ddfb5c-e858-4398-86e6-649fc4f99618@linux.ibm.com>
Date: Thu, 30 Apr 2026 16:10:18 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] KVM: s390: Add map/unmap ioctl and clean mappings
 post-guest
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: Douglas Freimuth <freimuth@linux.ibm.com>, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com, frankja@linux.ibm.com, david@kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260423235316.3665-1-freimuth@linux.ibm.com>
 <20260423235316.3665-2-freimuth@linux.ibm.com>
 <92f35384-7b03-4071-b7f9-32375b2badda@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <92f35384-7b03-4071-b7f9-32375b2badda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0uhh6m40Vy_JVHD6he4st-8EWYHGlEo2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDIwNSBTYWx0ZWRfXzBxd4puWi5/P
 4atvCnsg5+zVImd6oge7O5Af+pm8hNUNpInY6PCRofGyPNr9tCKjjR7Fj8kDsMa82s9XCjJa3PQ
 RZ++B9TpTUhWOYCo+n69q57aTj+vNJxPkXV1c14ddUt2wUkutuH9i/ZpyjHwwiZ+iQxS8VAqWO4
 mQXxS9bR+UXJ1z+mBN7MnCEP+z8DFDG5wWZ9kHcfKBL3rgPs8Wj1titzDm/dhnSVHKNgxrRH5zv
 X8pbgEik++O/SeuSiH7mFVVLxaDaF2wFr2mphRdl8Y3Ye/XPAUjzZsrX99rCR0mvyF5kKGKdwwK
 xZi+6ARwxhHlKQ7ZBxeUTkjETUr7TYAcbWmWY8OMZjTbhfu5cMgCWGym2/eSTfJ1InGqqo2R095
 rkr1iGEQMZMvUUjGzVefSjCnGeNdorxwGkxu18kBzi5o/mdSxcx8VdjaC1QdOAp6dSDW5m9jiEe
 agbn7p3UilEF22gwCfw==
X-Authority-Analysis: v=2.4 cv=VZLH+lp9 c=1 sm=1 tr=0 ts=69f3b72d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=8e5omm5uqKrRgawulIEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 0uhh6m40Vy_JVHD6he4st-8EWYHGlEo2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300205

On 4/29/26 10:44 AM, Matthew Rosato wrote:
> 
>> +static struct page *get_map_page(struct kvm *kvm, u64 uaddr)
>> +{
>> +	struct mm_struct *mm = kvm->mm;
>> +	struct page *page = NULL;
>> +	int locked = 1;
>> +
>> +	if (mmget_not_zero(mm)) {
>> +		mmap_read_lock(mm);
>> +		get_user_pages_remote(mm, uaddr, 1, FOLL_WRITE,
>> +				      &page, &locked);
> 
> I have wondered this before, and Sashiko mentions it now:  Would it make
> sense to also FOLL_LONGTERM here?
> 
> I recognize that the old ioctl code that you are resurrecting here did
> not use FOLL_LONGTERM, but I can't think of a reason why.
> 
> The mapping may indeed be held long-term (life of the guest or at least
> the associated adapter in the guest), and it's effectively under
> userspace control, waiting for a corresponding unmap ioctl or for the
> guest to go away or enter pv mode.
> 
> Can you please test?
> 

OK, I did some more looking into this.  FOLL_LONGTERM will require
FOLL_PIN, and you're using FOLL_GET here.  So that won't work as-is with
this code.

So let's step back and consider what these pages are intended to be used
for; we want to write to them prior to injecting an adapter interrupt
into a guest vm.  That seems to me to fall under case 5 in
Documentation/core-api/pin_user_pages.rst which says to use FOLL_PIN.

Whether we keep the page pinned for a long period of time or not depends
on whether or not it was mapped by userspace via the ioctl in this patch
-- but the intent is the same.

So I wonder if really we should be using pin_user_pages_remote here,
with (FOLL_WRITE | FOLL_LONGTERM) for the map/unmap ioctl case added by
this patch but also switch to pin_user_pages_remote() instead of
get_user_pages_remote() using only FOLL_WRITE for the existing 'slow'
path where we expect to pin, write some bits into the page and then
unpin the page right away

And of course unpin_user_page() instead of put_page() for both cases...

Christian / Janosch / Claudio, does this sound sane to you?

I did a quick test with the following diff on top of this series (ran
some I/O over virtio-ccw and virio-pci, saw io_390_inatomic numbers
going up) -- Doug can you give it a more thorough testing and if it
looks good / assuming no objections work it into your next version?


diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index ee3376b017cb..0960b6726f03 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -2453,7 +2453,8 @@ int kvm_s390_mask_adapter(struct kvm *kvm, unsigned int id, bool masked)
        return ret;
 }
 
-static struct page *get_map_page(struct kvm *kvm, u64 uaddr)
+static struct page *pin_map_page(struct kvm *kvm, u64 uaddr,
+                                unsigned int gup_flags)
 {
        struct mm_struct *mm = kvm->mm;
        struct page *page = NULL;
@@ -2461,7 +2462,7 @@ static struct page *get_map_page(struct kvm *kvm, u64 uaddr)
 
        if (mmget_not_zero(mm)) {
                mmap_read_lock(mm);
-               get_user_pages_remote(mm, uaddr, 1, FOLL_WRITE,
+               pin_user_pages_remote(mm, uaddr, 1, FOLL_WRITE | gup_flags,
                                      &page, &locked);
                if (locked)
                        mmap_read_unlock(mm);
@@ -2498,7 +2499,7 @@ static int kvm_s390_adapter_map(struct kvm *kvm, unsigned int id, __u64 addr)
        srcu_read_unlock(&kvm->srcu, idx);
        map->guest_addr = addr;
        map->addr = host_addr;
-       map->page = get_map_page(kvm, host_addr);
+       map->page = pin_map_page(kvm, host_addr, FOLL_LONGTERM);
        if (!map->page) {
                ret = -EINVAL;
                goto out;
@@ -2509,7 +2510,7 @@ static int kvm_s390_adapter_map(struct kvm *kvm, unsigned int id, __u64 addr)
                adapter->nr_maps++;
                ret = 0;
        } else {
-               put_page(map->page);
+               unpin_user_page(map->page);
                ret = -EINVAL;
        }
        raw_spin_unlock_irqrestore(&adapter->maps_lock, flags);
@@ -2550,7 +2551,7 @@ static int kvm_s390_adapter_unmap(struct kvm *kvm, unsigned int id, __u64 addr)
                mark_page_dirty(kvm, map_addr_to_mark >> PAGE_SHIFT);
                set_page_dirty_lock(map_page_to_put);
                srcu_read_unlock(&kvm->srcu, idx);
-               put_page(map_page_to_put);
+               unpin_user_page(map_page_to_put);
        }
 
        return found ? 0 : -ENOENT;
@@ -2569,7 +2570,7 @@ void kvm_s390_destroy_adapters(struct kvm *kvm)
                list_for_each_entry_safe(map, tmp,
                                         &kvm->arch.adapters[i]->maps, list) {
                        list_del(&map->list);
-                       put_page(map->page);
+                       unpin_user_page(map->page);
                        kfree(map);
                }
                raw_spin_unlock_irqrestore(&kvm->arch.adapters[i]->maps_lock, flags);
@@ -2899,7 +2900,7 @@ static int adapter_indicators_set(struct kvm *kvm,
        ind_info = get_map_info(adapter, adapter_int->ind_addr);
        if (!ind_info) {
                raw_spin_unlock_irqrestore(&adapter->maps_lock, flags);
-               ind_page = get_map_page(kvm, adapter_int->ind_addr);
+               ind_page = pin_map_page(kvm, adapter_int->ind_addr, 0);
                if (!ind_page)
                        return -1;
                idx = srcu_read_lock(&kvm->srcu);
@@ -2921,11 +2922,11 @@ static int adapter_indicators_set(struct kvm *kvm,
        summary_info = get_map_info(adapter, adapter_int->summary_addr);
        if (!summary_info) {
                raw_spin_unlock_irqrestore(&adapter->maps_lock, flags);
-               summary_page = get_map_page(kvm, adapter_int->summary_addr);
+               summary_page = pin_map_page(kvm, adapter_int->summary_addr, 0);
                if (!summary_page) {
                        if (!ind_info) {
                                WARN_ON_ONCE(!ind_page);
-                               put_page(ind_page);
+                               unpin_user_page(ind_page);
                        }
                        return -1;
                }
@@ -2946,9 +2947,9 @@ static int adapter_indicators_set(struct kvm *kvm,
        }
 
        if (!ind_info)
-               put_page(ind_page);
+               unpin_user_page(ind_page);
        if (!summary_info)
-               put_page(summary_page);
+               unpin_user_page(summary_page);
        return summary_set ? 0 : 1;
 }
 





