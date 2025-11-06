Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F39A3469EC;
	Thu,  6 Nov 2025 16:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762445372; cv=none; b=WAa4KSjMOxu18v5nodwCoeUqUns3S/+ydCi913jOeMl2fOFB/M/gGAHNsQAPepzpGDNLPW4y72kEzR3jPxW6Z+zIkcXJ8TqAAP12xQb1IL89pPfBJoyYFnIJZj77IAG4ebt4GVzI5VI9b/Fbxcgd/XQPArG9l5nEtocQzTVJt4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762445372; c=relaxed/simple;
	bh=cxY9Tm6JexU4JgbHJ5D03HNVlk+bcKz95WHi0wk858A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LQsQ4MA2KqOFmT/YqYEt2QqvQqrv+9zCau9aZnPQc1dSBJ25gO5Lq8+CNuiYGVFWZkRvRQB3imcoG7L2VHPmJXFZGhwLDg6Ob5JhFy8zIOMdWo2Xcx51xalMs5pUFc3ueWMTmgocDj7XvV9WEvNMK9P8+ddV0ryG4c8/daBqIjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BgE4t36R; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BgE4t36R"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A67Xlmb000310;
	Thu, 6 Nov 2025 16:09:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=NYh0v76lnnQ3448DO
	lCadXAQLR6tTdT6eiDqsyjof9o=; b=BgE4t36R0Eqa6Th+cG5xGJL4pv3AGBRVO
	7nnTZjOeGrw8AAYnPVYrgJT6g3iy5/2Y9im94JLe7xTmgoA2v0pN0qRbqHVzRFqn
	J0s4pINlbm3/2jAsvRZMeO4Hn+sTpquLaJjH1V8p7xfqbP9zKm7tVDrfbCmCYc7H
	xGMxIFf2XSea9MIXvei72YFwYYfnLoI2oxOxm1/qVL/hDsj6KBusBl1iR6S7Tuu9
	LFxxzqhgZRRahSahyVz1OR4NRGAgta0qT19TG+sBGJHn+W4O+SlQd4EV+CdYg8nR
	3vspaUME8LF4+7eQpnX+EnNF+tE1rIpfCd3sZIs1wlHUFZEkpuf+A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a58mm79ap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Nov 2025 16:09:22 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5A6FxNug017676;
	Thu, 6 Nov 2025 16:09:21 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a58mm79am-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Nov 2025 16:09:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6CqSmw012872;
	Thu, 6 Nov 2025 16:09:20 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a5y826222-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Nov 2025 16:09:20 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A6G9H3930474584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Nov 2025 16:09:17 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE02520043;
	Thu,  6 Nov 2025 16:09:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A59520040;
	Thu,  6 Nov 2025 16:09:16 +0000 (GMT)
Received: from li-26e6d1cc-3485-11b2-a85c-83dbc1845c5e.ibm.com.com (unknown [9.111.24.158])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Nov 2025 16:09:15 +0000 (GMT)
From: Aleksei Nikiforov <aleksei.nikiforov@linux.ibm.com>
To: Alexander Potapenko <glider@google.com>
Cc: Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
        Juergen Christ <jchrist@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Aleksei Nikiforov <aleksei.nikiforov@linux.ibm.com>
Subject: [PATCH 2/2] s390/fpu: Fix kmsan in fpu_vstl function
Date: Thu,  6 Nov 2025 17:08:48 +0100
Message-ID: <20251106160845.1334274-6-aleksei.nikiforov@linux.ibm.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20251106160845.1334274-2-aleksei.nikiforov@linux.ibm.com>
References: <20251106160845.1334274-2-aleksei.nikiforov@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hBw4vXcqyPgYlawhBneQH0p8B8IjDLLf
X-Proofpoint-GUID: n58oJVejSDjFVhiU14KfQNzRI4mJJQv6
X-Authority-Analysis: v=2.4 cv=SqidKfO0 c=1 sm=1 tr=0 ts=690cc832 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=uQN6hylD5dkGw-m7VIQA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAwOSBTYWx0ZWRfX9k7jBE+kZL0x
 SRPl4xn1zcpKVIzqzpkTGRBglAr9Aaf3xvzt5d9Fg9qFihXpLK37q0EhmQzuuyCi67wH/Pa9R1k
 zn5jVXTLD/U064fWWUbpr0iA25CUWH/aHLIGVBXbAXxctzzMonOXlSmulyfrmNesGbwOt/CepH5
 83r6u8nJ4g+GYYH6/yWW/mtfd118yNZrazvSPOR6U67QRJXJvrpws0W5Bprkz00U5XyI3cOYy/r
 n28LaUGoCbMBLQh4+9aMsY8xNDUBpRnluMAXWnkVM/lnznULC6FIdbJRFLJ2pyxysZM+N0g/GXq
 UUg4DZi0/T/FuDtrWbpi4nMDbNvFw6odaVpBWdcVvVkPDL73L9TpKwpvMgpDtJaeLo5Am5zeWoE
 344Fp7HzeXqKZmPpqb8Lk52w7r2dgg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 impostorscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010009

clang generates call to __msan_instrument_asm_store with 1 byte as size.
Manually call kmsan helper to indicate correct amount of bytes written.

If function fpu_vstl is called with argument 'index' > 0,
it writes at least 2 bytes, but kmsan only marks first byte as written.

This change fixes following kmsan reports:

[   36.563119] =====================================================
[   36.563594] BUG: KMSAN: uninit-value in virtqueue_add+0x35c6/0x7c70
[   36.563852]  virtqueue_add+0x35c6/0x7c70
[   36.564016]  virtqueue_add_outbuf+0xa0/0xb0
[   36.564266]  start_xmit+0x288c/0x4a20
[   36.564460]  dev_hard_start_xmit+0x302/0x900
[   36.564649]  sch_direct_xmit+0x340/0xea0
[   36.564894]  __dev_queue_xmit+0x2e94/0x59b0
[   36.565058]  neigh_resolve_output+0x936/0xb40
[   36.565278]  __neigh_update+0x2f66/0x3a60
[   36.565499]  neigh_update+0x52/0x60
[   36.565683]  arp_process+0x1588/0x2de0
[   36.565916]  NF_HOOK+0x1da/0x240
[   36.566087]  arp_rcv+0x3e4/0x6e0
[   36.566306]  __netif_receive_skb_list_core+0x1374/0x15a0
[   36.566527]  netif_receive_skb_list_internal+0x1116/0x17d0
[   36.566710]  napi_complete_done+0x376/0x740
[   36.566918]  virtnet_poll+0x1bae/0x2910
[   36.567130]  __napi_poll+0xf4/0x830
[   36.567294]  net_rx_action+0x97c/0x1ed0
[   36.567556]  handle_softirqs+0x306/0xe10
[   36.567731]  irq_exit_rcu+0x14c/0x2e0
[   36.567910]  do_io_irq+0xd4/0x120
[   36.568139]  io_int_handler+0xc2/0xe8
[   36.568299]  arch_cpu_idle+0xb0/0xc0
[   36.568540]  arch_cpu_idle+0x76/0xc0
[   36.568726]  default_idle_call+0x40/0x70
[   36.568953]  do_idle+0x1d6/0x390
[   36.569486]  cpu_startup_entry+0x9a/0xb0
[   36.569745]  rest_init+0x1ea/0x290
[   36.570029]  start_kernel+0x95e/0xb90
[   36.570348]  startup_continue+0x2e/0x40
[   36.570703]
[   36.570798] Uninit was created at:
[   36.571002]  kmem_cache_alloc_node_noprof+0x9e8/0x10e0
[   36.571261]  kmalloc_reserve+0x12a/0x470
[   36.571553]  __alloc_skb+0x310/0x860
[   36.571844]  __ip_append_data+0x483e/0x6a30
[   36.572170]  ip_append_data+0x11c/0x1e0
[   36.572477]  raw_sendmsg+0x1c8c/0x2180
[   36.572818]  inet_sendmsg+0xe6/0x190
[   36.573142]  __sys_sendto+0x55e/0x8e0
[   36.573392]  __s390x_sys_socketcall+0x19ae/0x2ba0
[   36.573571]  __do_syscall+0x12e/0x240
[   36.573823]  system_call+0x6e/0x90
[   36.573976]
[   36.574017] Byte 35 of 98 is uninitialized
[   36.574082] Memory access of size 98 starts at 0000000007aa0012
[   36.574218]
[   36.574325] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G    B            N  6.17.0-dirty #16 NONE
[   36.574541] Tainted: [B]=BAD_PAGE, [N]=TEST
[   36.574617] Hardware name: IBM 3931 A01 703 (KVM/Linux)
[   36.574755] =====================================================

[   63.532541] =====================================================
[   63.533639] BUG: KMSAN: uninit-value in virtqueue_add+0x35c6/0x7c70
[   63.533989]  virtqueue_add+0x35c6/0x7c70
[   63.534940]  virtqueue_add_outbuf+0xa0/0xb0
[   63.535861]  start_xmit+0x288c/0x4a20
[   63.536708]  dev_hard_start_xmit+0x302/0x900
[   63.537020]  sch_direct_xmit+0x340/0xea0
[   63.537997]  __dev_queue_xmit+0x2e94/0x59b0
[   63.538819]  neigh_resolve_output+0x936/0xb40
[   63.539793]  ip_finish_output2+0x1ee2/0x2200
[   63.540784]  __ip_finish_output+0x272/0x7a0
[   63.541765]  ip_finish_output+0x4e/0x5e0
[   63.542791]  ip_output+0x166/0x410
[   63.543771]  ip_push_pending_frames+0x1a2/0x470
[   63.544753]  raw_sendmsg+0x1f06/0x2180
[   63.545033]  inet_sendmsg+0xe6/0x190
[   63.546006]  __sys_sendto+0x55e/0x8e0
[   63.546859]  __s390x_sys_socketcall+0x19ae/0x2ba0
[   63.547730]  __do_syscall+0x12e/0x240
[   63.548019]  system_call+0x6e/0x90
[   63.548989]
[   63.549779] Uninit was created at:
[   63.550691]  kmem_cache_alloc_node_noprof+0x9e8/0x10e0
[   63.550975]  kmalloc_reserve+0x12a/0x470
[   63.551969]  __alloc_skb+0x310/0x860
[   63.552949]  __ip_append_data+0x483e/0x6a30
[   63.553902]  ip_append_data+0x11c/0x1e0
[   63.554912]  raw_sendmsg+0x1c8c/0x2180
[   63.556719]  inet_sendmsg+0xe6/0x190
[   63.557534]  __sys_sendto+0x55e/0x8e0
[   63.557875]  __s390x_sys_socketcall+0x19ae/0x2ba0
[   63.558869]  __do_syscall+0x12e/0x240
[   63.559832]  system_call+0x6e/0x90
[   63.560780]
[   63.560972] Byte 35 of 98 is uninitialized
[   63.561741] Memory access of size 98 starts at 0000000005704312
[   63.561950]
[   63.562824] CPU: 3 UID: 0 PID: 192 Comm: ping Tainted: G    B            N  6.17.0-dirty #16 NONE
[   63.563868] Tainted: [B]=BAD_PAGE, [N]=TEST
[   63.564751] Hardware name: IBM 3931 A01 703 (KVM/Linux)
[   63.564986] =====================================================

Fixes: dcd3e1de9d17 ("s390/checksum: provide csum_partial_copy_nocheck()")
Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Aleksei Nikiforov <aleksei.nikiforov@linux.ibm.com>
---
 arch/s390/include/asm/fpu-insn.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/include/asm/fpu-insn.h b/arch/s390/include/asm/fpu-insn.h
index 135bb89c0a89..151b17e22923 100644
--- a/arch/s390/include/asm/fpu-insn.h
+++ b/arch/s390/include/asm/fpu-insn.h
@@ -393,6 +393,7 @@ static __always_inline void fpu_vstl(u8 v1, u32 index, const void *vxr)
 		     : [vxr] "=Q" (*(u8 *)vxr)
 		     : [index] "d" (index), [v1] "I" (v1)
 		     : "memory");
+	instrument_write_after(vxr, size);
 }
 
 #else /* CONFIG_CC_HAS_ASM_AOR_FORMAT_FLAGS */
@@ -409,6 +410,7 @@ static __always_inline void fpu_vstl(u8 v1, u32 index, const void *vxr)
 		: [vxr] "=R" (*(u8 *)vxr)
 		: [index] "d" (index), [v1] "I" (v1)
 		: "memory", "1");
+	instrument_write_after(vxr, size);
 }
 
 #endif /* CONFIG_CC_HAS_ASM_AOR_FORMAT_FLAGS */
-- 
2.43.7

