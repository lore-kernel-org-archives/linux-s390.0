Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E78AC432BE
	for <linux-s390@archiver.kernel.org>; Thu, 26 Aug 2021 09:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E56A5610A1
	for <linux-s390@archiver.kernel.org>; Thu, 26 Aug 2021 09:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240674AbhHZJHf (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 26 Aug 2021 05:07:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4496 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240657AbhHZJHf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 26 Aug 2021 05:07:35 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17Q95FC6156696;
        Thu, 26 Aug 2021 05:06:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=pp1;
 bh=BdrYN073JkJXYnKYViotbHLEznESEx2D4kfxU+ZaTvI=;
 b=LKwBBCzHI9TwgIGWPiK+m8PRfigdNRVVlvPpVV7AjdmO9OXHvqwWeme055of3tSMz8mR
 +sumKVTuWCNVCoC1IOlDxDdA1M/Q4xJ7vdKImgcmqNyOCGOfAwdX/ZxEA2WO0SySsE1/
 vuMn6Qb+kHxxSxSTe7u72otiS9CZErrYorYbIErPm0hRxdKg77tMJ6bg5MhA+UpocLFo
 E+sb5OF1X5/oNbhFSEyafT0YqALHjuT92AIMvAZZ8mQpAaqakriAcK1tnQZebLl3XWeI
 FkADec4cmZjrQPJPpE7qCx3RlyZRhn13+iOAm7vhYxGa8JzG8sGZjpWvUm4PaeGy9OVP Rg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ap1kj12h1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Aug 2021 05:06:41 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17Q8wsb3020256;
        Thu, 26 Aug 2021 09:06:39 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 3ajrrhh010-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Aug 2021 09:06:39 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17Q92oC361276634
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Aug 2021 09:02:50 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF9104C04E;
        Thu, 26 Aug 2021 09:06:33 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00E474C081;
        Thu, 26 Aug 2021 09:06:33 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 26 Aug 2021 09:06:32 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        hca@linux.ibm.com
Subject: crash on s390 with SCHED_CORE=y
Date:   Thu, 26 Aug 2021 11:06:31 +0200
Message-ID: <yt9d35qwa82w.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: i24icF58UrksW2YvFCEQPhiHrUWsUymt
X-Proofpoint-ORIG-GUID: i24icF58UrksW2YvFCEQPhiHrUWsUymt
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-26_02:2021-08-25,2021-08-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 adultscore=0 suspectscore=0 malwarescore=0
 phishscore=0 mlxlogscore=369 bulkscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108260054
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Peter,

i'm seeing the following crash on s390 with the strace testsuite (namely
the prctl-sched-core--pidns-translation testcase).

[   25.044039] Unable to handle kernel pointer dereference in virtual kernel address space
[   25.044051] Failing address: 0000000000000000 TEID: 0000000000000483
[   25.044053] Fault in home space mode while using kernel ASCE.
[   25.044056] AS:0000000166bd4007 R3:00000003fffe8007 S:00000003fffed800 P:000000000000003d
[   25.044080] Oops: 0004 ilc:2 [#1] SMP
[   25.044085] Modules linked in: nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables nfnetlink sunrpc dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua s390_trng ghash_s390 ism p
rng smc aes_s390 des_s390 libdes ib_core sha3_512_s390 sha3_256_s390 sha512_s390 sha256_s390 sha1_s390 sha_common eadm_sch vfio_ccw mdev vfio_iommu_type1 vfio sch_fq_codel pkey zcrypt rng_core configfs ip_tables x_tables autofs4
[   25.044125] CPU: 122 PID: 2045 Comm: prctl-sched-cor Not tainted 5.14.0-rc7-08025-gf6d7568b37df-dirty #532
[   25.044129] Hardware name: IBM 8561 T01 701 (LPAR)
[   25.044130] Krnl PSW : 0404e00180000000 00000001655b7534 (raw_spin_rq_lock_nested+0x5c/0xb8)
[   25.044142]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
[   25.044145] Krnl GPRS: ffffffffffffffff 0000000000000000 000000030000007b 0000000000000000
[   25.044147]            0000000000000000 0000000000000000 0000000100000080 0000000166ad0900
[   25.044149]            0000000000000400 0000000100000000 0000000000000000 00000003fd9a3600
[   25.044150]            000000009fb50000 0000000166172538 00000380077cbd00 00000380077cbcc0
[   25.044158] Krnl Code: 00000001655b752a: b90400ab            lgr     %r10,%r11
[   25.044158]            00000001655b752e: 582003ac            l       %r2,940
[   25.044158]           #00000001655b7532: 1819                lr      %r1,%r9
[   25.044158]           >00000001655b7534: ba12a000            cs      %r1,%r2,0(%r10)
[   25.044158]            00000001655b7538: ec16001d007e        cij     %r1,0,6,00000001655b7572
[   25.044158]            00000001655b753e: e310b1300112        lt      %r1,4400(%r11)
[   25.044158]            00000001655b7544: a7740012            brc     7,00000001655b7568
[   25.044158]            00000001655b7548: b904001b            lgr     %r1,%r11
[   25.044230] Call Trace:
[   25.044234]  [<00000001655b7534>] raw_spin_rq_lock_nested+0x5c/0xb8
[   25.044241]  [<00000001655d2cfc>] online_fair_sched_group+0x9c/0x1c0
[   25.044248]  [<00000001655e481c>] sched_autogroup_create_attach+0xdc/0x210
[   25.044253]  [<000000016559a45e>] ksys_setsid+0x10e/0x148
[   25.044258]  [<000000016559a4ba>] __s390_sys_setsid+0x22/0x30
[   25.044261]  [<000000016608402c>] __do_syscall+0x1bc/0x1e8
[   25.044266]  [<0000000166091358>] system_call+0x78/0xa0
[   25.044269] Last Breaking-Event-Address:
[   25.044270]  [<0000000000000000>] 0x0
[   25.044274] Kernel panic - not syncing: Fatal exception: panic_on_oops

The crash is caused by using a NULL rq->core value in
__rq_lockp, which is then passed on to raw_spin_rq_lock_nested(). This
is because it is implemented as follows:

static inline raw_spinlock_t *__rq_lockp(struct rq *rq)
{
        if (rq->core_enabled)
		return &rq->core->__lock;
	return &rq->__lock;
}

The problem is, that __sched_core_flip() sets rq->core_enabled to 1 even
for offline CPUS:

	/*
	 * Toggle the offline CPUs.
	 */
	cpumask_copy(&sched_core_mask, cpu_possible_mask);
	cpumask_andnot(&sched_core_mask, &sched_core_mask, cpu_online_mask);

	for_each_cpu(cpu, &sched_core_mask)
		cpu_rq(cpu)->core_enabled = enabled;

... But rq->core seems to get only assigned in the cpu hotplug notifer
sched_core_cpu_starting(), which is never called for offline CPUs. At
least i haven't found another place which assigns rq->core.

Any thoughts?

Thanks
Svem
