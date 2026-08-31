Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE393ED5B6;
	Mon, 31 Aug 2026 10:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170465; cv=none; b=FP+XtqXGK1uWNugePpWg41blVm3krZtePix0JOo1nU/HqdN5EKsI+UF2uQ6Lfq1XWawBG6jIsMlPY5HnwoLaYkE9CKCe1y+U3v4aWhca25TQwLDydY4QmfZRYB5oy2IlzEUADiv9YmaV6dY09yd5meOQ7oF8yQqOgZeq6wIIn7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170465; c=relaxed/simple;
	bh=UHXiK+2wPlvrPzjnQNVS7btV4PjfAxg2S3vPqZ7EJNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uzNfdKEQJ2vek3OfJRAoIx19hVtfT9MC33vcAfY2vG+j0neO/UAyyy0OpN0BtecyjuQwYymwvld87KsAmEjt03ygKKZaZswrngr7Bh+NseB+b9pC2Jx3quelcpGxv/pU1C/93lKpj9cK0fnsRGIorFI1iiZ1sZpCTL3wzUM4CcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=m+4BR36o; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="m+4BR36o"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V82P9B1640487;
	Mon, 31 Aug 2026 10:00:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dAonsd
	otnxClF/j5+upZcKC3LgcUzP8274aPq8QRIY4=; b=m+4BR36ouEdJBzzv1YJ2Rd
	nJwHhjFk/+Yo21DigpDrwDahRx5vQeHKDaNdhdlSTBxMCSvXY13rvY78welBnO8q
	A3XcdyRd8rIUHeFsTER6RmMZB1rHey97Pw/v+h7CPiMT6Ujy5es9UKDNdvqGQue2
	ZA0xd74l63PU6cWMfgz5gYiGF3lpAB674XCYBq+75d01Zqv+6Oi/JN5qC/wdGRy5
	pniCIwXdBFls9BaM6oCSYxv16bBdZ7yE3ytApB7PbKdMKVpJd9tNUmlMjiRKVF3F
	EfZeu/Y5DcG/IwSKPbDDChMBuEfTafSizI5ns20cmCfA6f0N7f3Nr9rgoFRVbOMQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx58ha0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 10:00:57 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67V9uOK4024984;
	Mon, 31 Aug 2026 10:00:56 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcbyg51n8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 10:00:56 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VA0twa33096432
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 10:00:55 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 848585805D;
	Mon, 31 Aug 2026 10:00:55 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2128358059;
	Mon, 31 Aug 2026 10:00:50 +0000 (GMT)
Received: from [9.123.0.223] (unknown [9.123.0.223])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 10:00:49 +0000 (GMT)
Message-ID: <37021811-78ac-4bdd-ab59-62fb089850f3@linux.ibm.com>
Date: Mon, 31 Aug 2026 15:30:48 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] module: init-failure path can free a module with live
 try_module_get() users
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Aaron Tomlin <atomlin@atomlin.com>, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, "D. Wythe" <alibuda@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Tony Lu
 <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Hidayath Khan <hidayath@linux.ibm.com>
References: <5dc1fe2b-289e-4786-b9e9-e181dda8d4e9@linux.ibm.com>
 <8b6506a1-5bfc-4f9b-92fa-234c89afe9ad@suse.com>
Content-Language: en-US
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
In-Reply-To: <8b6506a1-5bfc-4f9b-92fa-234c89afe9ad@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a9550d9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=Bmp3t_kZ57zNF6DfwVUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: JuENR-MDDg3XZpXSo-5dKm2MmJNYow_B
X-Proofpoint-ORIG-GUID: 0yzz6gdF7xbs_MNMZMpwgprYkX1NdiAp
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA4MiBTYWx0ZWRfX8J94zLdW4/eU
 M0gJyy+lkUFSa0iAjGwHYLizGBCqhwBlp03aLR8OjQ7xBb5/IpdzKf6uFZqN0W8nWoHKnctd0x7
 EqoJyf1YlFDH1nXUZ311zhd4vi45P50=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA4MiBTYWx0ZWRfXzr1mYNKb/Iov
 VW6ZkGipP+5AKmYFt26gvqICJzuo0F9fUR5OVUCSAXwsb1TQuAd7N22gHyH5L1N7TsCQKcxsGV+
 y4Jwy7svvS8C7WWDSJ5Ail96R2GLocTXSs/jvzXwcyMdMF3DvFWzwbEMCr8HYes2is29Be95UGR
 ev8LCuETWuOuxKH1DejUntQCRFGn3nlm5SHDmRSFNEPVp+s/sfu0Z9fnpWVxTmoxKnHFYBI5ypK
 gi+FXlL7yH6dLB5e6WWX37W0tYbJqz00dAagz4SzZqAfF3BpdNP/3JAd/99vfxYefJiVh9IJwnz
 axrW/RO84AWq2sP9pMJL29e9iMLNUl5yEfM8GOo8TKryf4EMb/eauLPykRaI/TLJMC12MJ+8Hwu
 QKzbUUoUVbUCW7QjyLe20JgYtrhkNriJ5vdpfIF9SWHtsVyOMjs8B/VJAMYTmnqdgya0pIV0Xhc
 VXdkrpP2Yoq/rMKeV2g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310082



On 28/08/26 5:33 pm, Petr Pavlu wrote:
> On 8/24/26 8:13 AM, Mahanta Jambigi wrote:
>> Hi Luis, Petr, Daniel, Sami, Aaron,
>>
>> I'm writing to ask about what looks like a generic module-init failure
>> lifetime problem in the module loader. I ran into it while working on
>> the SMC networking module (net/smc/), but after several patch
>> iterations, it seems the root issue may belong in kernel/module/main.c
>> rather than in SMC itself. I'd appreciate your guidance on whether this
>> reading is correct, and if so, what fix direction would be preferred.
>>
>> THE ISSUE IN do_init_module()
>> =============================
>>
>> include/linux/module.h has a long-standing FIXME in module_is_live():
>>
>>     /* FIXME: It'd be nice to isolate modules during init, too, so they
>>        aren't used before they (may) fail. But presently too much code
>>        (IDE & SCSI) require entry into the module during init. */
>>     static inline bool module_is_live(struct module *mod)
>>     {
>>         return mod->state != MODULE_STATE_GOING;
>>     }
>>
>> Because MODULE_STATE_COMING is not MODULE_STATE_GOING, try_module_get()
>> can succeed once a module's __init is executing. If __init makes the
>> module externally reachable partway through and then later fails, the
>> failure path in do_init_module() appears to do:
>>
>>     fail:
>>         mod->state = MODULE_STATE_GOING;
>>         synchronize_rcu();
>>         module_put(mod);
>>         ...
>>         free_module(mod);
>>
>> synchronize_rcu() waits for RCU readers, but not for threads that
>> already obtained a module reference via try_module_get() and are still
>> executing module text.
>>
>> By contrast, the normal unload path in try_stop_module() refuses to
>> proceed while the refcount is non-zero.
>>
>> So the asymmetry seems to be that the normal unload path waits for
>> references to drain, while the init-failure path does not.
>>
>> A concrete race would look like:
>>
>>   1. Module __init registers an externally reachable interface.
>>   2. User space enters through that interface and try_module_get()
>>      succeeds while the module is still COMING.
>>   3. A later __init step fails.
>>   4. do_init_module() frees the module.
>>   5. The in-flight caller is still executing module text.
>>
>> SMC AS A CONCRETE EXAMPLE
>> =========================
>>
>> In SMC, simply moving registration later does not appear to eliminate
>> the window, because there are two separate registration points that can
>> make the module reachable via socket():
>>
>>   1. sock_register(&smc_sock_family_ops)
>>      After this, socket(AF_SMC, ...) can succeed and reach
>>      try_module_get() via __sock_create().
>>
>>   2. smc_inet_init() -> inet_register_protosw()
>>      After this, socket(AF_INET, SOCK_STREAM, IPPROTO_SMC) can succeed
>>      and again reach try_module_get().
>>
>> Either registration point can succeed before a later init step fails.
>>
>> This may not be specific to SMC; other protocol modules that become
>> reachable during init, such as Bluetooth, may have similar exposure and
>> appear worth auditing as well.
>>
>> ON THE FIXME'S IDE/SCSI CONCERN
>> ===============================
>>
>> The FIXME mentions IDE and SCSI as reasons not to isolate modules
>> during init.
>>
>>   1. IDE was removed in Linux 5.14, so that half of the concern no
>>      longer applies.
>>
>>   2. SCSI still appears to self-reference during init
>>      (scsi_device_get() -> try_module_get(hostt->module) during
>>      scsi_scan_host()), so a blanket wait-for-refcount-to-drain
>>      approach in the failure path may deadlock there.
>>
>> Also, strong_try_module_get() already rejects MODULE_STATE_COMING with
>> -EBUSY, so the infrastructure for refusing callers during init already
>> exists in some form.
>>
>> QUESTIONS
>> =========
>>
>> First, is my reading of this init-failure refcount/lifetime asymmetry
>> correct?
> 
> Your analysis looks correct to me.
> 
>>
>> If so, would one of the following directions be acceptable?
>>
>>   1. An opt-in mechanism (for example, a module flag) for modules that
>>      are safe to isolate during init and whose init-failure path should
>>      wait for external references to drain.
> 
> In general, it is preferred if the module loader handles all modules in
> the same way.
> 
> I would say that the module loader should wait for external references
> to drain after an init failure for all modules and that it should be the
> responsibility of individual modules to ensure that this wait eventually
> completes. Excluding some modules would mean that the module loader
> could still free them while they are in use by the kernel.
> 
> Before such a wait, the module loader should cancel all idempotent
> module loads. This is especially important during boot when several
> udevd workers may be trying to insert the same module. In that case,
> a failed module init function should block only a single udevd task, so
> that the system can still boot properly.
> 
Thank you for the clear direction. I agree with both points — uniform
handling for all modules, and unblocking concurrent loaders before the
drain wait. Below is the proposed change with the rationale for each
step. Proposed change to the fail: path in do_init_module().

fail_free_freeinit:
	kfree(freeinit);
fail:
	/*
	 * Mark dying so try_module_get() fails for all new callers.
	 * synchronize_rcu() ensures this is visible on all CPUs before
	 * we proceed; no new references can be taken after this point.
	 */
	mod->state = MODULE_STATE_GOING;
	synchronize_rcu();

	/* Drop the loader's own reference taken in module_unload_init(). */
	module_put(mod);

	/*
	 * Unblock concurrent loaders before blocking on the drain below,
	 * so that a failed init delays only this task, not every udevd
	 * worker that raced to load the same module.
	 *
	 * Two dedup paths exist:
	 *
	 * - finit_module path: losers of the inode race sleep in
	 *   idempotent_wait_for_completion(). They are unblocked by
	 *   idempotent_complete() in idempotent_init_module(), which
	 *   runs as do_init_module() returns — before we reach here.
	 *   No action needed.
	 *
	 * - init_module path: callers sleep in module_patient_check_exists()
	 *   on module_wq waiting for finished_loading(), which returns
	 *   true once state == MODULE_STATE_GOING. wake_up_all() kicks
	 *   them loose immediately.
	 */
	*wake_up_all*(&module_wq);

	/*
	 * Drain async workers scheduled during __init (e.g. SCSI async
	 * scan). MODULE_STATE_GOING is visible everywhere, so workers
	 * that have not yet called try_module_get() will fail cleanly.
	 * Workers already holding a reference complete and release it
	 * naturally. Must run before free_module() regardless of
	 * async_probe_requested.
	 */
	*async_synchronize_full*();

	/*
	 * Wait for references taken before MODULE_STATE_GOING became
	 * visible. refcnt is monotonically decreasing from here; the
	 * loop terminates provided the module's error path pairs every
	 * __module_get() with a module_put(). The hung-task detector
	 * catches violations.
	 */
	while (*module_refcount*(mod) != 0)
		msleep(10);

	blocking_notifier_call_chain(&module_notify_list,
				     MODULE_STATE_GOING, mod);
	klp_module_going(mod);
	ftrace_release_mod(mod);
	free_module(mod);

	return ret;

Does this direction look correct to you?
