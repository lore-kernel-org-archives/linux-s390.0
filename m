Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5661DE3DB;
	Wed,  8 Oct 2025 06:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759906017; cv=none; b=Xr+3kkAWVirSh/RMfXmZtcZftVVWsIAVsRpWPupOvSD0reCN1X7kum7FEfc6NjkIMQ9MZYF/umS1GwfqLDeNGep8fBcjNHXLAUzcMJeVj2I9jKVUsDDwTxtX0cUgtb/WYyXZb8N/c8C9jlGcK/2QX/rTuBP1Frl8D2kgtq+a3E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759906017; c=relaxed/simple;
	bh=ELJUZNVXN1Mg6KFpZ8Rj3g0FIRt2gLZFtGPtI89y5V0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eFBISceKhNqKrl4tYlUiTjTAGFXxTe7ncy90iiAOgUsGnX9ASYC8FuiUen12pbvOorPcoYTasGfoF98m2fVGOxms815XgXcwggc8wMF36kJ4mIvs17Rr23PXl+ZGBGtxKvKTUfTAkkjS10Px0aYyFRpUndUXPIJrny/RwDwS7+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Tg/o41NQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Tg/o41NQ"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 597JvRol023877;
	Wed, 8 Oct 2025 06:46:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Sp0zBwq0Bh5uCXTC/zQduQKA2VE//U
	qtoRaO4GquUkI=; b=Tg/o41NQpIJUDE8aQCEps3Kw46Z13bCwR+Vbc0vjyEEVU4
	l2R0MSxsjtUhp/cI/gf7kQuvc9dDiqbar8FPsPnHLmMyO5qeQwY8dtZotPhslHe+
	YNJrIsLoLgxwT8iFmO60V1vGvwn/0OpZXG4fFhAgYYUJn+2sw5K5iTpOUCYMx46x
	7VK1pGdCtO2N93VI4N3ueAQYsWLPoDZSkP4lV6JVTaOsJHe96NN7uJaPiOrSd2Ft
	f8YWoUn8sO+cfyAF66LKeY+OVOlM8YiFryzAa5wT3uqQhTUuChUSjgnaa9aiSsxL
	xahDGbZQaE77RHNaR75+zXp9Y6ahtWcs5cz/Pn4A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49ju93ke7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 06:46:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5986kbU8021272;
	Wed, 8 Oct 2025 06:46:48 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49kgm1exgj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 06:46:48 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5986ki4146596540
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Oct 2025 06:46:44 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 88B392004B;
	Wed,  8 Oct 2025 06:46:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 88B8220040;
	Wed,  8 Oct 2025 06:46:40 +0000 (GMT)
Received: from li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com (unknown [9.111.14.160])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  8 Oct 2025 06:46:40 +0000 (GMT)
Date: Wed, 8 Oct 2025 08:46:24 +0200
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH 2/4] s390/sclp: Add support for dynamic (de)configuration
 of memory
Message-ID: <aOYIwEGgrjpNMGKD@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
References: <20250926131527.3260733-1-sumanthk@linux.ibm.com>
 <20250926131527.3260733-3-sumanthk@linux.ibm.com>
 <4e832570-32f8-46a5-80d0-40570db862b2@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e832570-32f8-46a5-80d0-40570db862b2@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lhaUsBPuKtPFfyoxk5ODsubvb1IbGELj
X-Proofpoint-ORIG-GUID: lhaUsBPuKtPFfyoxk5ODsubvb1IbGELj
X-Authority-Analysis: v=2.4 cv=Fec6BZ+6 c=1 sm=1 tr=0 ts=68e608d9 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=Uk5sRPGcfaKE-AGN8r8A:9
 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyMiBTYWx0ZWRfXxvcC32YPIvrD
 sNVxv7+5yzVkDhmIL5dwuYng0vDR9GrY13Av8QHzE0YKQk6epHKr7+WICDaVyryj8VLG2LBGZL5
 WrHh9mT0yy/dKMqt/1aa2UMP3KofyP1DzHUWuim58t3M/b+HkJnmKmdvmwoKtO9+eeLSXQCbsXA
 NTD+7KVi/VkA+U8iaAMYHjkfGSJ7Y9y7s9aQBiVpKr4EO8YLjB/3RO0op5SHQ91iWSU52BpM7aN
 YHpZ14VrB4hHPI53f78gY/nfSeGl1muX2rCKj7XJyhoU9D5sdOlT5HHB9CEYBehKNhVm27RDxyB
 QpdpTBhkDxWRvgI7YLZ5aBxGxy/lQfTsng6dlPg4diJNDpcm3y7R4yd9PIW4czXcaRi//6znDla
 wvHje1I8BLNY6OL7EWlvKhpapp+PMw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040022

On Tue, Oct 07, 2025 at 10:07:43PM +0200, David Hildenbrand wrote:
> [...]
> 
> > ---
> >   drivers/s390/char/sclp_mem.c | 291 +++++++++++++++++++++++++++++------
> >   1 file changed, 241 insertions(+), 50 deletions(-)
> > 
> > diff --git a/drivers/s390/char/sclp_mem.c b/drivers/s390/char/sclp_mem.c
> > index 27f49f5fd358..802439230294 100644
> > --- a/drivers/s390/char/sclp_mem.c
> > +++ b/drivers/s390/char/sclp_mem.c
> > @@ -9,9 +9,12 @@
> >   #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> >   #include <linux/cpufeature.h>
> > +#include <linux/container_of.h>
> >   #include <linux/err.h>
> >   #include <linux/errno.h>
> >   #include <linux/init.h>
> > +#include <linux/kobject.h>
> > +#include <linux/kstrtox.h>
> >   #include <linux/memory.h>
> >   #include <linux/memory_hotplug.h>
> >   #include <linux/mm.h>
> > @@ -27,7 +30,6 @@
> >   #define SCLP_CMDW_ASSIGN_STORAGE		0x000d0001
> >   #define SCLP_CMDW_UNASSIGN_STORAGE		0x000c0001
> > -static DEFINE_MUTEX(sclp_mem_mutex);
> >   static LIST_HEAD(sclp_mem_list);
> >   static u8 sclp_max_storage_id;
> >   static DECLARE_BITMAP(sclp_storage_ids, 256);
> > @@ -38,6 +40,18 @@ struct memory_increment {
> >   	int standby;
> >   };
> > +struct mblock {
> > +	struct kobject kobj;
> > +	unsigned int id;
> > +	unsigned int memmap_on_memory;
> > +	unsigned int config;
> > +};
> > +
> > +struct memory_block_arg {
> > +	struct mblock *mblocks;
> > +	struct kset *kset;
> > +};
> 
> I would avoid using "memory_block_arg" as it reminds of core mm "struct memory_block".
> 
> Similarly, I'd not call this "mblock".
> 
> What about incorporating the "sclp" side of things?
> 
> "struct sclp_mem" / "struct sclp_mem_arg"
> 
> Nicely fits "sclp_mem.c" ;)
> 
> Something like that might be better.

Sure. I will change it. Thanks

> > +
> >   struct assign_storage_sccb {
> >   	struct sccb_header header;
> >   	u16 rn;
> > @@ -185,15 +199,11 @@ static int sclp_mem_notifier(struct notifier_block *nb,
> >   {
> >   	unsigned long start, size;
> >   	struct memory_notify *arg;
> > -	unsigned char id;
> >   	int rc = 0;
> >   	arg = data;
> >   	start = arg->start_pfn << PAGE_SHIFT;
> >   	size = arg->nr_pages << PAGE_SHIFT;
> > -	mutex_lock(&sclp_mem_mutex);
> > -	for_each_clear_bit(id, sclp_storage_ids, sclp_max_storage_id + 1)
> > -		sclp_attach_storage(id);
> >   	switch (action) {
> >   	case MEM_GOING_OFFLINE:
> >   		/*
> > @@ -204,45 +214,201 @@ static int sclp_mem_notifier(struct notifier_block *nb,
> >   		if (contains_standby_increment(start, start + size))
> >   			rc = -EPERM;
> >   		break;
> 
> Is there any reson this notifier is still needed? I'd assume we can just allow
> for offlining + re-onlining as we please now.
> 
> In fact, I'd assume we can get rid of the notifier entirely now?

I was initially uncertain about contains_standby_increment() use case
and didnt change it here.  However, after testing by removing the
contains_standby_increment() checks, I observed that the common memory
hotplug code already prevents offlining a memory block that contains
holes. This ensures safety without relying on these checks.

c5e79ef561b0 ("mm/memory_hotplug.c: don't allow to online/offline memory blocks with holes")

i.e. #cp define storage 3504M standby 2148M
This leads to a configuration where memory block 27 contains both
assigned and standby incr.

But, offlining it will not succeed:
chmem -d 0x00000000d8000000-0x00000000dfffffff
chmem: Memory Block 27 (0x00000000d8000000-0x00000000dfffffff) disable
failed: Invalid argument

Hence, I will remove it. Thanks.

> > -	case MEM_PREPARE_ONLINE:
> > -		/*
> > -		 * Access the altmap_start_pfn and altmap_nr_pages fields
> > -		 * within the struct memory_notify specifically when dealing
> > -		 * with only MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE notifiers.
> > -		 *
> > -		 * When altmap is in use, take the specified memory range
> > -		 * online, which includes the altmap.
> > -		 */
> > -		if (arg->altmap_nr_pages) {
> > -			start = PFN_PHYS(arg->altmap_start_pfn);
> > -			size += PFN_PHYS(arg->altmap_nr_pages);
> > -		}
> > -		rc = sclp_mem_change_state(start, size, 1);
> > -		if (rc || !arg->altmap_nr_pages)
> > -			break;
> > -		/*
> > -		 * Set CMMA state to nodat here, since the struct page memory
> > -		 * at the beginning of the memory block will not go through the
> > -		 * buddy allocator later.
> > -		 */
> > -		__arch_set_page_nodat((void *)__va(start), arg->altmap_nr_pages);
> > +	default:
> >   		break;
> > -	case MEM_FINISH_OFFLINE:
> > +	}
> > +	return rc ? NOTIFY_BAD : NOTIFY_OK;
> > +}
> > +
> > +static ssize_t config_mblock_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
> > +{
> > +	struct mblock *mblock = container_of(kobj, struct mblock, kobj);
> > +
> > +	return sysfs_emit(buf, "%u\n", READ_ONCE(mblock->config));
> > +}
> > +
> > +static ssize_t config_mblock_store(struct kobject *kobj, struct kobj_attribute *attr,
> > +				   const char *buf, size_t count)
> > +{
> > +	unsigned long long addr, block_size;
> 
> "unsigned long" should be sufficient I'm sure :)

Left over. I will do so.

> > +	struct memory_block *mem;
> > +	struct mblock *mblock;
> > +	unsigned char id;
> > +	bool value;
> > +	int rc;
> > +
> > +	rc = kstrtobool(buf, &value);
> > +	if (rc)
> > +		return rc;
> > +	mblock = container_of(kobj, struct mblock, kobj);
> > +	block_size = memory_block_size_bytes();
> > +	addr = mblock->id * block_size;
> > +	/*
> > +	 * Hold device_hotplug_lock when adding/removing memory blocks.
> > +	 * Additionally, also protect calls to find_memory_block() and
> > +	 * sclp_attach_storage().
> > +	 */
> > +	rc = lock_device_hotplug_sysfs();
> > +	if (rc)
> > +		goto out;
> > +	for_each_clear_bit(id, sclp_storage_ids, sclp_max_storage_id + 1)
> > +		sclp_attach_storage(id);
> > +	if (value) {
> > +		if (mblock->config)
> > +			goto out_unlock;
> > +		rc = sclp_mem_change_state(addr, block_size, 1);
> > +		if (rc)
> > +			goto out_unlock;
> >   		/*
> > -		 * When altmap is in use, take the specified memory range
> > -		 * offline, which includes the altmap.
> > +		 * Set entire memory block CMMA state to nodat. Later, when
> > +		 * page tables pages are allocated via __add_memory(), those
> > +		 * regions are marked __arch_set_page_dat().
> >   		 */
> > -		if (arg->altmap_nr_pages) {
> > -			start = PFN_PHYS(arg->altmap_start_pfn);
> > -			size += PFN_PHYS(arg->altmap_nr_pages);
> > +		__arch_set_page_nodat((void *)__va(addr), block_size >> PAGE_SHIFT);
> > +		rc = __add_memory(0, addr, block_size,
> > +				  mblock->memmap_on_memory ?
> > +				  MHP_MEMMAP_ON_MEMORY | MHP_OFFLINE_INACCESSIBLE : MHP_NONE);
> > +		if (rc)
> > +			goto out_unlock;
> 
> Do we have to undo the state change?

Intention was to keep error handling simple. In case of failure in
add_memory(), we would have state set to 1 (not given back). But,
subsequent configuration request for that block will not have an impact.

...

> > +static int create_mblock(struct mblock *mblock, struct kset *kset,
> > +			 unsigned int id, bool config, bool memmap_on_memory)
> > +{
> > +	int rc;
> > +
> > +	mblock->memmap_on_memory = memmap_on_memory;
> > +	mblock->config = config;
> > +	mblock->id = id;
> > +	kobject_init(&mblock->kobj, &ktype);
> > +	rc = kobject_add(&mblock->kobj, &kset->kobj, "memory%d", id);
> > +	if (rc)
> > +		return rc;
> > +	rc = sysfs_create_group(&mblock->kobj, &mblock_attr_group);
> > +	if (rc)
> > +		kobject_put(&mblock->kobj);
> > +	return rc;
> > +}
> > +
> > +/*
> > + * Create /sys/firmware/memory/memoryX for boottime configured online memory
> > + * blocks
> > + */
> > +static int create_online_mblock(struct memory_block *mem, void *argument)
> 
> "online" is conusing. It's "initial" / "configured". Same applies to the other functions
> that mention "online".

Sure. I will change it.

> > +{
> > +	struct memory_block_arg *arg;
> > +	struct mblock *mblocks;
> > +	struct kset *kset;
> > +	unsigned int id;
> > +
> > +	id = mem->dev.id;
> > +	arg = (struct memory_block_arg *)argument;
> > +	mblocks = arg->mblocks;
> > +	kset = arg->kset;
> > +	return create_mblock(&mblocks[id], kset, id, true, false);
> > +}
> > +
> > +static int __init create_initial_online_mblocks(struct mblock *mblocks, struct kset *kset)
> > +{
> > +	struct memory_block_arg arg;
> > +
> > +	arg.mblocks = mblocks;
> > +	arg.kset = kset;
> > +	return for_each_memory_block(&arg, create_online_mblock);
> > +}
> > +
> > +static struct mblock * __init allocate_mblocks(void)
> > +{
> > +	u64 max_mblocks;
> 
> Nit: why an u64? The block ids are "unsigned int id;"

Sure. I will correct it.

> > +	u64 block_size;
> > +
> > +	block_size = memory_block_size_bytes();
> > +	max_mblocks = roundup(sclp.rnmax * sclp.rzm, block_size) / block_size;
> > +	return kcalloc(max_mblocks, sizeof(struct mblock), GFP_KERNEL);
> 
> 
> I think you should structure the code a bit differently, not splitting
> the function up into tiny helpers.
> 
> static int __init init_sclp_mem(void)
> {
> 	const u64 block_size = memory_block_size_bytes();
> 	const u64 max_mblocks = roundup(sclp.rnmax * sclp.rzm, block_size) / block_size;
> 	struct sclp_mem_arg arg;
> 	struct kset *kset;
> 	int rc;
> 	
> 	/* We'll allocate memory for all blocks ahead of time. */
> 	sclp_mem = kcalloc(max_mblocks, sizeof(struct mblock), GFP_KERNEL);
> 	if (!sclp_mem)
> 		return -ENOMEM;
> 
> 	kset = kset_create_and_add("memory", NULL, firmware_kobj);
> 	if (!kset)
> 		return -ENOMEM;
> 
> 	/* Initial memory is in the "configured" state already. */
> 	arg.sclp_mem = sclp_mem;
> 	arg.kset = kset;
> 	rc = for_each_memory_block(&arg, create_configured_sclp_mem);
> 	if (rc)
> 		return rc;
> 
> 	/* Standby memory is "deconfigured". */
> 	return create_standby_sclp_mem(sclp_mem, kset);
> }
> 
> Should still be quite readable.

Then, I'll make use of it.

...

> > -static int __init sclp_detect_standby_memory(void)
> > +static int __init sclp_setup_memory(void)
> >   {
> >   	struct read_storage_sccb *sccb;
> >   	int i, id, assigned, rc;
> > +	struct mblock *mblocks;
> > +	struct kset *kset;
> >   	/* No standby memory in kdump mode */
> >   	if (oldmem_data.start)
> 
> Wouldn't we still want to create the ones for initial memory at least?

Intention was the following: 
configuration and deconfiguration of memory with optional
memmap-on-memory is mostly needed for only standby memory.

If standby memory is absent or sclp is unavailable, we continue using
the previous behavior (only software offline/online), since the sclp
memory notifier was not registered in that case before either.

Thank you David
