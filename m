Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B771B55C34;
	Fri,  8 Mar 2024 11:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709896176; cv=none; b=khGRxWyPJIW2nZGLD4dlM6OJlvAohYAOUZiT48t56zxvUgALwcJUpWOCs394QQZOWpGRs2ZzGnQGzApqUAcfEE6Gx6TSHv/IYjB2iGVj570ENlHdAiDGnWEBa3AhdHJQspsbWWO5zB3BBuSiKanZaUmibSAsrMlbAuRnC6l0bwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709896176; c=relaxed/simple;
	bh=uhF7KeuFS5kvVj74c+K5uPLZQLXkKWbLmov+lBPwnxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9bn5Z/IGRD1mKKM72ehkU7eqjfLmuxUfFvwqivAc0C3jp+dXzZZvNdhbFKkx/HKWFwgi0ysqri9MszxZq1lZ+fBPmnsdWqmeTRqiW2GFp7I4KX/rxzPFIU7X2OOoEddwHwU20QYTt4yHQlKtR0jYZdaNOnhvMcubanOzBnJVkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Pp/2CHnD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Pp/2CHnD"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 428AvAxu006147;
	Fri, 8 Mar 2024 11:09:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=gyDQg7SwnM6C8Lf//yiK9B+QJkkbKBHdWa1O2wRLrkQ=;
 b=Pp/2CHnDKRhACe2XruLb1PYYN3uAKfGb12w2nU5D01NMgAJWMoSsAfdkoEuAfAvqR2hl
 28ZFl6SdIvFSLDLvbRgmdr4Mq6AP17gd+SNgbXzqGWBFJGk9td1zQhl8BHabRgMX0noQ
 3g1YDSOSXpQq1k17BlA6ml4UlkwbG3q4cQxeo7/GM5qC5kyk0qgSfp7mNUbHvolPhveD
 47R2teS/ctPBsB/Kc28vKU7jIi9epnUTZNlwmCMu+QI80cvWHrmA+eUPBmni1ikbB1WY
 5zkFd6RMTHBcd00hwEk1dmJffJ7jGrafLNjwgtpJZhJuU5zXZ7oATs+GbQL3xgUgO9o9 6A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr1cdr6r6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 11:09:31 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 428B9K6G008895;
	Fri, 8 Mar 2024 11:09:30 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr1cdr6qq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 11:09:30 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 428B963T026183;
	Fri, 8 Mar 2024 11:09:29 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wmfepc05a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 11:09:29 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 428B9NHR49611072
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Mar 2024 11:09:25 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9FE3F2004E;
	Fri,  8 Mar 2024 11:09:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E21F42004B;
	Fri,  8 Mar 2024 11:09:22 +0000 (GMT)
Received: from osiris (unknown [9.171.32.39])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  8 Mar 2024 11:09:22 +0000 (GMT)
Date: Fri, 8 Mar 2024 12:09:21 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>
Subject: Re: [PATCH net v2] s390/qeth: handle deferred cc1
Message-ID: <20240308110921.26074-D-hca@linux.ibm.com>
References: <20240307093827.2307279-1-wintera@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307093827.2307279-1-wintera@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _eAgk7EIxsmeHJeydRVBBSbQ6aM_z0yp
X-Proofpoint-ORIG-GUID: Yp8HqP6l1nxQxE7qXywvtKgPC9xCMIEC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxlogscore=882 priorityscore=1501 clxscore=1011
 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403080088

On Thu, Mar 07, 2024 at 10:38:27AM +0100, Alexandra Winter wrote:
> The IO subsystem expects a driver to retry a ccw_device_start, when the
> subsequent interrupt response block (irb) contains a deferred
> condition code 1.
> 
> Symptoms before this commit:
> On the read channel we always trigger the next read anyhow, so no
> different behaviour here.
> On the write channel we may experience timeout errors, because the
> expected reply will never be received without the retry.
> Other callers of qeth_send_control_data() may wrongly assume that the ccw
> was successful, which may cause problems later.
> 
> Note that since
> commit 2297791c92d0 ("s390/cio: dont unregister subchannel from child-drivers")
> and
> commit 5ef1dc40ffa6 ("s390/cio: fix invalid -EBUSY on ccw_device_start")
> deferred CC1s are more likely to occur. See the commit message of the
> latter for more background information.
> 
> Fixes: 2297791c92d0 ("s390/cio: dont unregister subchannel from child-drivers")
> Reference-ID: LTC205042
> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
> ---
> v1->v2: correct patch format
> 
>  drivers/s390/net/qeth_core_main.c | 36 +++++++++++++++++++++++++++++--
>  1 file changed, 34 insertions(+), 2 deletions(-)

This patch seems to introduce a reference count problem, which results
in use-after-free reports like the one below. So, please ignore the
patch - this needs to be sorted out first.

[  553.017253] ------------[ cut here ]------------
[  553.017255] refcount_t: addition on 0; use-after-free.
[  553.017269] WARNING: CPU: 12 PID: 115746 at lib/refcount.c:25 refcount_warn_saturate+0x10e/0x130
[  553.017275] Modules linked in: kvm algif_hash af_alg nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables nfnetlink dm_service_time mlx5_ib ib_uverbs ib_core uvdevice
+s390_trng eadm_sch vfio_ccw mdev vfio_iommu_type1 vfio sch_fq_codel loop configfs lcs ctcm fsm zfcp scsi_transport_fc mlx5_core ghash_s390 prng chacha_s390 libchacha aes_s390 des_s390 libdes sha3_512_s390 sha3_256_s390 sha512_s390 sha256_s390 sha1_s390 sha_common scsi_dh_rdac scsi_dh_emc scsi_dh_alua pkey
+zcrypt rng_core dm_multipath autofs4
[  553.017331] Unloaded tainted modules: test_klp_state3(K):1 test_klp_state2(K):4 test_klp_state(K):3 test_klp_callbacks_demo2(K):2 test_klp_callbacks_demo(K):12 test_klp_atomic_replace(K):2 test_klp_livepatch(K):6 [last unloaded: kvm]
[  553.017405] CPU: 12 PID: 115746 Comm: qeth_recover Tainted: G        W     K    6.8.0-20240305.rc7.git1.570c73d6a3df.300.fc39.s390x #1
[  553.017408] Hardware name: IBM 8561 T01 701 (LPAR)
[  553.017409] Krnl PSW : 0404c00180000000 00000001a53cad02 (refcount_warn_saturate+0x112/0x130)
[  553.017413]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
[  553.017415] Krnl GPRS: c000000000000027 0000000000000023 000000000000002a 0000000100000000
[  553.017417]            00000004b38e0900 0000000000000000 0000000095dfc2c0 0000000000001000
[  553.017419]            00000001a563eb58 000000009938d818 0000000000001007 000000009938d800
[  553.017421]            0000000095dfac00 0000000000000000 00000001a53cacfe 000003800f24bc10
[  553.017426] Krnl Code: 00000001a53cacf2: c020004f67d8        larl    %r2,00000001a5db7ca2
                          00000001a53cacf8: c0e5ffc262b4        brasl   %r14,00000001a4c17260
                         #00000001a53cacfe: af000000            mc      0,0
                         >00000001a53cad02: a7f4ff9a            brc     15,00000001a53cac36
                          00000001a53cad06: 92014008            mvi     8(%r4),1
                          00000001a53cad0a: c020004f67f6        larl    %r2,00000001a5db7cf6
                          00000001a53cad10: c0e5ffc262a8        brasl   %r14,00000001a4c17260
                          00000001a53cad16: af000000            mc      0,0
[  553.017439] Call Trace:
[  553.017440]  [<00000001a53cad02>] refcount_warn_saturate+0x112/0x130
[  553.017443] ([<00000001a53cacfe>] refcount_warn_saturate+0x10e/0x130)
[  553.017445]  [<00000001a563db88>] __qeth_issue_next_read+0x270/0x288
[  553.017448]  [<00000001a563dc38>] qeth_mpc_initialize.constprop.0+0x98/0x738
[  553.017449]  [<00000001a564007e>] qeth_hardsetup_card+0x36e/0xb38
[  553.017451]  [<00000001a56408d8>] qeth_set_online+0x90/0x3a0
[  553.017453]  [<00000001a5640d04>] qeth_do_reset+0x11c/0x1f8
[  553.017455]  [<00000001a4c47f30>] kthread+0x120/0x128
[  553.017458]  [<00000001a4bc3014>] __ret_from_fork+0x3c/0x58
[  553.017460]  [<00000001a58d717a>] ret_from_fork+0xa/0x30
[  553.017463] Last Breaking-Event-Address:
[  553.017464]  [<00000001a4c172de>] __warn_printk+0x7e/0xf0
[  553.017467] ---[ end trace 0000000000000000 ]---
[  553.017474] qeth 0.0.bd00: The qeth device driver failed to recover an error on the device
[  553.018615] qeth 0.0.bd00: The qeth device driver failed to recover an error on the device
