Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7ACC433ED
	for <linux-s390@archiver.kernel.org>; Mon, 12 Apr 2021 11:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 877546100B
	for <linux-s390@archiver.kernel.org>; Mon, 12 Apr 2021 11:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239897AbhDLLFz (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 12 Apr 2021 07:05:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60902 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239824AbhDLLFz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 12 Apr 2021 07:05:55 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13CB3m2f136918;
        Mon, 12 Apr 2021 07:05:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=to : cc : references :
 from : message-id : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding : subject; s=pp1;
 bh=vMcqFRnw/ONXjJai0Vk1kQ3NgnTOwWa14alXWwY5BSE=;
 b=tViyVrwz0XApoyda3APRD8uBq1VNTQC/MYjKHtLaELrL2VF0tL0XvIIzQDZWdJ9LgCZX
 MsDrksop8o8waZQEVjDmvvvVtwJ9TK+B0NpZJIdsrQ8bsywf/VoAjbIH265BzlxX8ZVi
 2rtHzj4eVX3Gh3d0IyUcRUzM0AnW5m1jkHyi9Xx7I/ERB6wCUK1HBX/en76pTe7zt17/
 WAInR9M3Y9XM4fM4eVbzzRij6x9XQiTWfrq8qFerpdqLKFu9COa2GA2ykdlQfxileqDT
 DINb9vYK2YJQVKx8LzkBqX+PAb1lQcmVUUE5VVoM6pqosZ0q2SNDFo4SfqbWTUbFEqta 9w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37us2uyt8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Apr 2021 07:05:30 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13CB443O137610;
        Mon, 12 Apr 2021 07:05:30 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37us2uyt7e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Apr 2021 07:05:30 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13CB2ibu004381;
        Mon, 12 Apr 2021 11:05:27 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 37u39h8wme-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Apr 2021 11:05:27 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13CB5PJR4326018
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Apr 2021 11:05:25 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F7AEA404D;
        Mon, 12 Apr 2021 11:05:25 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75101A4053;
        Mon, 12 Apr 2021 11:05:24 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.171.95.131])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 12 Apr 2021 11:05:24 +0000 (GMT)
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com,
        linux-s390 <linux-s390@vger.kernel.org>
References: <20210401030141.37061-1-songmuchun@bytedance.com>
 <4b9c1b0c-00dc-97e0-0e17-b8467c4cb31d@de.ibm.com>
 <CAMZfGtVyKCdWKcY5wCwD+ocVy9JADJwgRs12vh4sbL3s8oRx9A@mail.gmail.com>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <f001f273-f345-2926-a6b7-3fbec7f6b094@de.ibm.com>
Date:   Mon, 12 Apr 2021 13:05:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CAMZfGtVyKCdWKcY5wCwD+ocVy9JADJwgRs12vh4sbL3s8oRx9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LXrilFP0N_HUDkz6gzd64JmnI2Iuclz4
X-Proofpoint-GUID: lHqBX7bS_8seO94e9I_Z8TM-GwmJzyPj
Subject: RE: [PATCH] mm: memcontrol: fix forget to obtain the ref to objcg in
 split_page_memcg
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-12_09:2021-04-12,2021-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 priorityscore=1501 adultscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104120074
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 12.04.21 12:53, Muchun Song wrote:
> On Mon, Apr 12, 2021 at 6:42 PM Christian Borntraeger
> <borntraeger@de.ibm.com> wrote:
>>
>> FWIW, I was away the last week, and I checked yesterdays next (e99d8a849517) regression runs.
>> I still do see errors in our CI system:
>>
>> [ 2263.021681] ------------[ cut here ]------------
>> [ 2263.021697] percpu ref (obj_cgroup_release) <= 0 (0) after switching to atomic
>> [ 2263.021748] WARNING: CPU: 4 PID: 0 at lib/percpu-refcount.c:196 percpu_ref_switch_to_atomic_rcu+0x1ea/0x1f8
>> [ 2263.021756] Modules linked in: scsi_debug vfio_pci irqbypass vfio_virqfd kvm vhost_vsock vmw_vsock_virtio_transport_common vsock vhost vhost_iotlb xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT xt_tcpudp nft_compat nf_nat_tftp nft_objref nf_conntrack_tftp nft_counter bridge stp llc nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables nfnetlink dm_service_time zfcp scsi_transport_fc dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua rpcrdma sunrpc rdma_ucm rdma_cm iw_cm ib_cm mlx5_ib dm_mod ib_uverbs ib_core s390_trng vfio_ccw vfio_mdev mdev vfio_iommu_type1 vfio eadm_sch zcrypt_cex4 sch_fq_codel configfs ip_tables x_tables ghash_s390 prng aes_s390 des_s390 libdes sha3_512_s390 sha3_256_s390 mlx5_core sha512_s390 sha256_s390 sha1_s390 sha_common nvme nvme_core pkey zcrypt rng_core autofs4 [last unloaded: vfio_ap]
>> [ 2263.021820] CPU: 4 PID: 0 Comm: swapper/4 Not tainted 5.12.0-20210412.rc6.git0.e99d8a849517.300.fc33.s390x+next #1
>> [ 2263.021823] Hardware name: IBM 8561 T01 703 (LPAR)
>> [ 2263.021825] Krnl PSW : 0704c00180000000 000000025b234c1e (percpu_ref_switch_to_atomic_rcu+0x1ee/0x1f8)
>> [ 2263.021829]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
>> [ 2263.021832] Krnl GPRS: c0000000fffeffff 00000002f7212818 0000000000000042 00000000fffeffff
>> [ 2263.021834]            00000000ffffffea 0000038000000001 0000000000000000 000003800000017c
>> [ 2263.021836]            000000025b980988 00000000b774d0e0 000003fee191d5d8 8000000000000000
>> [ 2263.021838]            000000008034c000 00000002f7227570 000000025b234c1a 00000380000aba28
>> [ 2263.021849] Krnl Code: 000000025b234c0e: e3309fe8ff04        lg      %r3,-24(%r9)
>>                             000000025b234c14: c0e5001ebe92        brasl   %r14,000000025b60c938
>>                            #000000025b234c1a: af000000            mc      0,0
>>                            >000000025b234c1e: a7f4ffcc            brc     15,000000025b234bb6
>>                             000000025b234c22: 0707                bcr     0,%r7
>>                             000000025b234c24: 0707                bcr     0,%r7
>>                             000000025b234c26: 0707                bcr     0,%r7
>>                             000000025b234c28: eb6ff0480024        stmg    %r6,%r15,72(%r15)
>> [ 2263.021912] Call Trace:
>> [ 2263.021914]  [<000000025b234c1e>] percpu_ref_switch_to_atomic_rcu+0x1ee/0x1f8
>> [ 2263.021917] ([<000000025b234c1a>] percpu_ref_switch_to_atomic_rcu+0x1ea/0x1f8)
>> [ 2263.021919]  [<000000025abe16fe>] rcu_do_batch+0x146/0x608
>> [ 2263.021924]  [<000000025abe5ff4>] rcu_core+0x124/0x1d0
>> [ 2263.021926]  [<000000025b62a222>] __do_softirq+0x13a/0x3c8
>> [ 2263.021930]  [<000000025ab5d3f6>] irq_exit+0xce/0xf8
>> [ 2263.021934]  [<000000025b61a5f6>] do_ext_irq+0xd6/0x160
>> [ 2263.021937]  [<000000025b627c3c>] ext_int_handler+0xc4/0xf4
>> [ 2263.021939]  [<0000000000000000>] 0x0
>> [ 2263.021943]  [<000000025b62775a>] default_idle_call+0x42/0x110
>> [ 2263.021945]  [<000000025ab99328>] do_idle+0xd8/0x168
>> [ 2263.021949]  [<000000025ab99576>] cpu_startup_entry+0x36/0x40
>> [ 2263.021952]  [<000000025ab1f33a>] smp_start_secondary+0x82/0x88
>> [ 2263.021955] Last Breaking-Event-Address:
>> [ 2263.021955]  [<000000025abc8828>] vprintk_emit+0xa8/0x110
>> [ 2263.021961] Kernel panic - not syncing: panic_on_warn set ...
>> [ 2263.021962] CPU: 4 PID: 0 Comm: swapper/4 Not tainted 5.12.0-20210412.rc6.git0.e99d8a849517.300.fc33.s390x+next #1
>> [ 2263.021964] Hardware name: IBM 8561 T01 703 (LPAR)
>> [ 2263.021965] Call Trace:
>> [ 2263.021966]  [<000000025b60bc9a>] show_stack+0x92/0xd8
>> [ 2263.021972]  [<000000025b6161c0>] dump_stack+0x90/0xc0
>> [ 2263.021975]  [<000000025b60cab2>] panic+0x112/0x308
>> [ 2263.021977]  [<000000025ab5571a>] __warn+0xc2/0x158
>> [ 2263.021981]  [<000000025b2a5e4a>] report_bug+0xb2/0x130
>> [ 2263.021984]  [<000000025ab09ef4>] monitor_event_exception+0x44/0xc0
>> [ 2263.021986]  [<000000025b61a1e8>] __do_pgm_check+0xe0/0x1f0
>> [ 2263.021988]  [<000000025b627b30>] pgm_check_handler+0x118/0x160
>> [ 2263.021990]  [<000000025b234c1e>] percpu_ref_switch_to_atomic_rcu+0x1ee/0x1f8
>> [ 2263.021992] ([<000000025b234c1a>] percpu_ref_switch_to_atomic_rcu+0x1ea/0x1f8)
>> [ 2263.021993]  [<000000025abe16fe>] rcu_do_batch+0x146/0x608
>> [ 2263.021995]  [<000000025abe5ff4>] rcu_core+0x124/0x1d0
>> [ 2263.021997]  [<000000025b62a222>] __do_softirq+0x13a/0x3c8
>> [ 2263.021998]  [<000000025ab5d3f6>] irq_exit+0xce/0xf8
>> [ 2263.022000]  [<000000025b61a5f6>] do_ext_irq+0xd6/0x160
>> [ 2263.022001]  [<000000025b627c3c>] ext_int_handler+0xc4/0xf4
>> [ 2263.022003]  [<0000000000000000>] 0x0
>> [ 2263.022004]  [<000000025b62775a>] default_idle_call+0x42/0x110
>> [ 2263.022006]  [<000000025ab99328>] do_idle+0xd8/0x168
>> [ 2263.022008]  [<000000025ab99576>] cpu_startup_entry+0x36/0x40
>>
>> So either the fix was not complete or it is still missing in next.
> 
> The fix now is on the mm-tree. I guess the branch you
> tested does not contain this fix patch. You can check if
> the function of obj_cgroup_get_many() exists. If it
> doesn't exist, this means my guess is correct.

Right, the next tree from april 9th does not yet contain obj_cgroup_get_many.
