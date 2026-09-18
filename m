Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1D23C1D4E;
	Fri, 18 Sep 2026 12:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789735024; cv=none; b=h60JgEraLu9mtz6s3gje2Ntr/7sIQ9LPPmzjJCjB3W5D0i4EcVzyDkG7tKeCiOWcuacVxdkMPT76G1ht5aX/BOKbCFJr/vmvqdzVz1mHqFrm4j+o57SXS3N269J+aOWyGu6g+R76XYpKbZ7FYuTUG94vo0mkknx7/SQppfaYWpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789735024; c=relaxed/simple;
	bh=cfvEKqECARmxM78+DTjTxzF4CBIfOfqw5l0ODkIbOQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TCOqqZpcCWkiXrd9ZYp7YQYqP7xDxrIVL3Cks3TbE2cZ6YN3XUpENpFRA1M6Yo+0UPCyaweagRdKSahEHLBE/5C36CTYoh83AUUvWoqsFWBuK+4yqRbdMrIXTGo4rTEvjcaDUyN0H3HxdSrec29OsvJh/sid/Y04qwlPWnwrwmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P/iY0Z5x; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P/iY0Z5x"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IA1el4803518;
	Fri, 18 Sep 2026 12:36:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=R4QrkT
	JhUKrNMrkYbBswSLyzZEjfroEF7UyVFAm4+DA=; b=P/iY0Z5xygBu8bUwgi95xJ
	WWAEkm4zW77wGHRdTuZv5o82Ss79n02PRB+mSmdZITfNTqxgEArx4djgaVqj68oY
	1poRgzY1SRSt8PSlpmtNOUMyUQKGwK0ROXa4ePMzuOK3McE9qkrm6Ueel2rFYJ8J
	5QakDLiOzbY4ftp5DBiqULI1cR4OjkcHlTgPIRd1WY9TNTWlK3XCOmIVxeLo2YY6
	BCb0D/kH6Im45JEfmKgUxbvnxVrBcf0ITrpmimommalLVadxJkz1f90Mj6vN7aKR
	APBTUFhkVSuhPSAtqgH8qoMJOQTDfTVnDtba+5ZU/jTNyX+ZM9dN2nmjVtrKAbfA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmv5j7ser-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 12:36:56 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68I9o52l507516;
	Fri, 18 Sep 2026 12:36:55 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gra3yxcda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 12:36:55 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68ICaso216450130
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 12:36:54 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00D7F58050;
	Fri, 18 Sep 2026 12:36:54 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 710EC58045;
	Fri, 18 Sep 2026 12:36:48 +0000 (GMT)
Received: from [9.111.130.41] (unknown [9.111.130.41])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 12:36:48 +0000 (GMT)
Message-ID: <47ed43e7-2cff-4ebf-8019-74716bcfc1be@linux.ibm.com>
Date: Fri, 18 Sep 2026 18:06:46 +0530
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
 <37021811-78ac-4bdd-ab59-62fb089850f3@linux.ibm.com>
 <90d4523b-70e7-44a2-9c8b-107f1087c18a@suse.com>
Content-Language: en-US
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
In-Reply-To: <90d4523b-70e7-44a2-9c8b-107f1087c18a@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDE3NyBTYWx0ZWRfX26uJ0XqChGYx
 3Iqwe179wedxlqKDeELUvYWR7fnUXP2M8UyGhs8tX2tkd3O+NfKeRXT2poIywKdrvacu0+qwb92
 /F2U6Fz5pIfLGrCZcw9BU4cMZ+8m94MupiSwxWkwAswoBxTcB1a2eU3yQj/LtXzWYJC0L8mVTPa
 m2sD24Hq3JFpdB1o/cYu0x4JDZ4HdTKbwPT9K3pwNLeZkuqebHOJzqfD/h3JI589zP4icVEdbuy
 BdeTrtGI/zOQ3FPkvKJc0DKF9ENiUUX/fI1o536qh7spQu9YuK6CthtQ7y3w0JeRDWB9xV55Q9+
 QbjSouFrneeHUsIZ1PixocqNDpcEhO+SBTy5Ya1+81qxn4bQJ0FCuDeKLktYE9Lht1+jKTMjAHh
 RbLteVlc/RUwWMhG+U1ozslOZfaF83Imix8jbVdbVWSAPhEWAK1tyM2C7zulRnc9yanS8TcFQAS
 /6CVasesD3bDPrdXiFw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDE3NyBTYWx0ZWRfX8t+LR9yKlKxu
 I2dpQoVlSmcYpOObOIKYU29Q4hQn6bKIzcWORfjVWRTI/Ff/e8IJPYPgxlRCiF+VdEPEzLhmACH
 UwqIz1/GGMabEu31hsu7zIIBb2yGejc=
X-Authority-Analysis: v=2.4 cv=Zsx4uN7G c=1 sm=1 tr=0 ts=6aad3068 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=33uV9nPcLkLvqYpI2OgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ZfQNrcWgH1VOClP3uWaiaBo-ceAPsgUA
X-Proofpoint-GUID: hc8xM54pDOu-D8rVQKUqb-AaLvLtK_lv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180177



On 08/09/26 5:40 pm, Petr Pavlu wrote:
> On 8/31/26 12:00 PM, Mahanta Jambigi wrote:
>> On 28/08/26 5:33 pm, Petr Pavlu wrote:
>>> On 8/24/26 8:13 AM, Mahanta Jambigi wrote:
>>>> Hi Luis, Petr, Daniel, Sami, Aaron,
>>>>
>>>> I'm writing to ask about what looks like a generic module-init failure
>>>> lifetime problem in the module loader. I ran into it while working on
>>>> the SMC networking module (net/smc/), but after several patch
>>>> iterations, it seems the root issue may belong in kernel/module/main.c
>>>> rather than in SMC itself. I'd appreciate your guidance on whether this
>>>> reading is correct, and if so, what fix direction would be preferred.
>>>>
>>>> THE ISSUE IN do_init_module()
>>>> =============================
>>>>
>>>> include/linux/module.h has a long-standing FIXME in module_is_live():
>>>>
>>>>     /* FIXME: It'd be nice to isolate modules during init, too, so they
>>>>        aren't used before they (may) fail. But presently too much code
>>>>        (IDE & SCSI) require entry into the module during init. */
>>>>     static inline bool module_is_live(struct module *mod)
>>>>     {
>>>>         return mod->state != MODULE_STATE_GOING;
>>>>     }
>>>>
>>>> Because MODULE_STATE_COMING is not MODULE_STATE_GOING, try_module_get()
>>>> can succeed once a module's __init is executing. If __init makes the
>>>> module externally reachable partway through and then later fails, the
>>>> failure path in do_init_module() appears to do:
>>>>
>>>>     fail:
>>>>         mod->state = MODULE_STATE_GOING;
>>>>         synchronize_rcu();
>>>>         module_put(mod);
>>>>         ...
>>>>         free_module(mod);
>>>>
>>>> synchronize_rcu() waits for RCU readers, but not for threads that
>>>> already obtained a module reference via try_module_get() and are still
>>>> executing module text.
>>>>
>>>> By contrast, the normal unload path in try_stop_module() refuses to
>>>> proceed while the refcount is non-zero.
>>>>
>>>> So the asymmetry seems to be that the normal unload path waits for
>>>> references to drain, while the init-failure path does not.
>>>>
>>>> A concrete race would look like:
>>>>
>>>>   1. Module __init registers an externally reachable interface.
>>>>   2. User space enters through that interface and try_module_get()
>>>>      succeeds while the module is still COMING.
>>>>   3. A later __init step fails.
>>>>   4. do_init_module() frees the module.
>>>>   5. The in-flight caller is still executing module text.
>>>>
>>>> SMC AS A CONCRETE EXAMPLE
>>>> =========================
>>>>
>>>> In SMC, simply moving registration later does not appear to eliminate
>>>> the window, because there are two separate registration points that can
>>>> make the module reachable via socket():
>>>>
>>>>   1. sock_register(&smc_sock_family_ops)
>>>>      After this, socket(AF_SMC, ...) can succeed and reach
>>>>      try_module_get() via __sock_create().
>>>>
>>>>   2. smc_inet_init() -> inet_register_protosw()
>>>>      After this, socket(AF_INET, SOCK_STREAM, IPPROTO_SMC) can succeed
>>>>      and again reach try_module_get().
>>>>
>>>> Either registration point can succeed before a later init step fails.
>>>>
>>>> This may not be specific to SMC; other protocol modules that become
>>>> reachable during init, such as Bluetooth, may have similar exposure and
>>>> appear worth auditing as well.
>>>>
>>>> ON THE FIXME'S IDE/SCSI CONCERN
>>>> ===============================
>>>>
>>>> The FIXME mentions IDE and SCSI as reasons not to isolate modules
>>>> during init.
>>>>
>>>>   1. IDE was removed in Linux 5.14, so that half of the concern no
>>>>      longer applies.
>>>>
>>>>   2. SCSI still appears to self-reference during init
>>>>      (scsi_device_get() -> try_module_get(hostt->module) during
>>>>      scsi_scan_host()), so a blanket wait-for-refcount-to-drain
>>>>      approach in the failure path may deadlock there.
>>>>
>>>> Also, strong_try_module_get() already rejects MODULE_STATE_COMING with
>>>> -EBUSY, so the infrastructure for refusing callers during init already
>>>> exists in some form.
>>>>
>>>> QUESTIONS
>>>> =========
>>>>
>>>> First, is my reading of this init-failure refcount/lifetime asymmetry
>>>> correct?
>>>
>>> Your analysis looks correct to me.
>>>
>>>>
>>>> If so, would one of the following directions be acceptable?
>>>>
>>>>   1. An opt-in mechanism (for example, a module flag) for modules that
>>>>      are safe to isolate during init and whose init-failure path should
>>>>      wait for external references to drain.
>>>
>>> In general, it is preferred if the module loader handles all modules in
>>> the same way.
>>>
>>> I would say that the module loader should wait for external references
>>> to drain after an init failure for all modules and that it should be the
>>> responsibility of individual modules to ensure that this wait eventually
>>> completes. Excluding some modules would mean that the module loader
>>> could still free them while they are in use by the kernel.
>>>
>>> Before such a wait, the module loader should cancel all idempotent
>>> module loads. This is especially important during boot when several
>>> udevd workers may be trying to insert the same module. In that case,
>>> a failed module init function should block only a single udevd task, so
>>> that the system can still boot properly.
>>>
>> Thank you for the clear direction. I agree with both points — uniform
>> handling for all modules, and unblocking concurrent loaders before the
>> drain wait. Below is the proposed change with the rationale for each
>> step. Proposed change to the fail: path in do_init_module().
>>
>> fail_free_freeinit:
>> 	kfree(freeinit);
>> fail:
>> 	/*
>> 	 * Mark dying so try_module_get() fails for all new callers.
>> 	 * synchronize_rcu() ensures this is visible on all CPUs before
>> 	 * we proceed; no new references can be taken after this point.
>> 	 */
>> 	mod->state = MODULE_STATE_GOING;
>> 	synchronize_rcu();
> 
> The comment is somewhat misleading. The code invokes synchronize_rcu()
> to wait for any existing RCU readers to finish before proceeding, making
> sure that all new readers now observe the GOING state.

synchronize_rcu() comment — agreed, updated wording:

"synchronize_rcu() waits for any in-progress RCU read-side critical
sections to complete, ensuring all CPUs observe MODULE_STATE_GOING
before we proceed."

>>
>> 	/* Drop the loader's own reference taken in module_unload_init(). */
>> 	module_put(mod);
>>
>> 	/*
>> 	 * Unblock concurrent loaders before blocking on the drain below,
>> 	 * so that a failed init delays only this task, not every udevd
>> 	 * worker that raced to load the same module.
>> 	 *
>> 	 * Two dedup paths exist:
>> 	 *
>> 	 * - finit_module path: losers of the inode race sleep in
>> 	 *   idempotent_wait_for_completion(). They are unblocked by
>> 	 *   idempotent_complete() in idempotent_init_module(), which
>> 	 *   runs as do_init_module() returns — before we reach here.
>> 	 *   No action needed.
> 
> This looks incorrect. Since this code is added in do_init_module(),
> idempotent_complete() has not yet been invoked.

finit_module / idempotent_complete ordering — you are right.
idempotent_complete() is called by idempotent_init_module() after
do_init_module() returns, not before.

> 
>> 	 *
>> 	 * - init_module path: callers sleep in module_patient_check_exists()
>> 	 *   on module_wq waiting for finished_loading(), which returns
>> 	 *   true once state == MODULE_STATE_GOING. wake_up_all() kicks
>> 	 *   them loose immediately.
>> 	 */
>> 	*wake_up_all*(&module_wq);
>>
>> 	/*
>> 	 * Drain async workers scheduled during __init (e.g. SCSI async
>> 	 * scan). MODULE_STATE_GOING is visible everywhere, so workers
>> 	 * that have not yet called try_module_get() will fail cleanly.
>> 	 * Workers already holding a reference complete and release it
>> 	 * naturally. Must run before free_module() regardless of
>> 	 * async_probe_requested.
>> 	 */
>> 	*async_synchronize_full*();
>>
>> 	/*
>> 	 * Wait for references taken before MODULE_STATE_GOING became
>> 	 * visible. refcnt is monotonically decreasing from here; the
>> 	 * loop terminates provided the module's error path pairs every
>> 	 * __module_get() with a module_put(). The hung-task detector
>> 	 * catches violations.
>> 	 */
>> 	while (*module_refcount*(mod) != 0)
>> 		msleep(10);
> 
> I think that instead of repeatedly polling the module refcount, it would
> be better for this code to sleep and for module_put() to wake it when
> the refcount drops to 0. This could be implemented using either the
> existing module_wq, a separate wait queue or a per-module completion.

Refcount drain — agreed that polling is poor style.  Of the three
approaches you suggested, a per-module completion is the cleanest fit
here.  module_wq is a global queue shared across all module loading
activity; reusing it for the drain would require a condition check on
every wake-up and risk spurious wakes across unrelated modules.  A
separate dedicated wait queue would work but adds more infrastructure
than needed for a single binary event.

A per-module struct completion is the right primitive for "wait for this
one thing to happen exactly once": add refs_gone to struct module inside
CONFIG_MODULE_UNLOAD, initialize it in module_unload_init(), and call
complete() from module_put() when refcnt drops to MODULE_REF_BASE.  The
fail: path then replaces the polling loop with a single
wait_for_completion(&mod->refs_gone).

Rather than continuing the design discussion I will send the patch
directly so it is easier to review concretely.
