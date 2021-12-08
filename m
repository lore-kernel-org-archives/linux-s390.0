Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72597C433F5
	for <linux-s390@archiver.kernel.org>; Wed,  8 Dec 2021 10:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbhLHLBk (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 8 Dec 2021 06:01:40 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59278 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230300AbhLHLBk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Dec 2021 06:01:40 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B88MVwd019842
        for <linux-s390@vger.kernel.org>; Wed, 8 Dec 2021 10:58:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=6kD2gRt+NTOn80ew5NhgZvQH5oISy5JBcunklMS1J40=;
 b=feqGDVmfQyvtEEGAjje1idr1YDKWnEG4Tg8I3jQELfmNuHlEqr3tRL0W8cUYGqBJykQn
 84QB2oEQZk9KjuCJxsbshFhhp2T+MG+C+FzOhlQVZFO2/9w7qXU1W2hrWYj+gTUCKSqO
 OHszXBKtd8tgZZpBTncktncxUAHZ2dHbs0H1xRXm6S10qMEpekpeYzcxjCs1ml765m2R
 LomWZzxaYdXee0SGI/VjMeCizSKyDA7dExJHxU6Qdz1yX7GGyNlCmF4t0MDLJ/YATguS
 z6Mf8bSvJ1g0ejJuhYPYbRkPYke38SRAFa1MMmFmceOZ9JOM1tazTC+A77J1zcKhxoGb 8g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cts50tqx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 08 Dec 2021 10:58:08 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B8Au7LW005349
        for <linux-s390@vger.kernel.org>; Wed, 8 Dec 2021 10:58:07 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cts50tqwn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Dec 2021 10:58:07 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B8AqUfS020533;
        Wed, 8 Dec 2021 10:58:05 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma01fra.de.ibm.com with ESMTP id 3cqyy9n9nx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Dec 2021 10:58:05 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B8Aw2t025362914
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Dec 2021 10:58:03 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D57324C058;
        Wed,  8 Dec 2021 10:58:02 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B6004C044;
        Wed,  8 Dec 2021 10:58:02 +0000 (GMT)
Received: from oc8242746057.lan (unknown [9.171.51.81])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  8 Dec 2021 10:58:02 +0000 (GMT)
From:   Alexander Egorenkov <egorenar@linux.ibm.com>
To:     ltao@redhat.com, prudo@redhat.com
Cc:     hca@linux.ibm.com, linux-s390@vger.kernel.org
Subject: [PATCH 1/1] s390/kexec: handle R_390_PLT32DBL reloc entries in arch_kexec_do_relocs()
Date:   Wed,  8 Dec 2021 11:58:01 +0100
Message-Id: <20211208105801.188140-1-egorenar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: laAUiBWc5B63oecw7Mbz7oYVe2UQ3wlu
X-Proofpoint-ORIG-GUID: eM573wwWVOJfnOK_juLepo9ThWZz5OZn
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-08_03,2021-12-08_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112080068
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Starting with gcc 11.3, the C compiler will generate PLT-relative function
calls even if they are local and do not require it. Later on during linking,
the linker will replace all PLT-relative calls to local functions with
PC-relative ones. Unfortunately, the purgatory code of kexec/kdump is
not being linked as a regular executable or shared library would have been,
and therefore, all PLT-relative addresses remain in the generated purgatory
object code unresolved. This leads to the situation where the purgatory
code is being executed during kdump with all PLT-relative addresses
unresolved. And this results in endless loops within the purgatory code.

Furthermore, the clang C compiler has always behaved like described above
and this commit should fix kdump for kernels built with the latter.

Because the purgatory code is no regular executable or shared library,
contains only calls to local functions and has no PLT, all R_390_PLT32DBL
relocation entries can be resolved just like a R_390_PC32DBL one.

* https://refspecs.linuxfoundation.org/ELF/zSeries/lzsabi0_zSeries/x1633.html#AEN1699

Relocation entries of purgatory code generated with gcc 11.3
------------------------------------------------------------

$ readelf -r linux/arch/s390/purgatory/purgatory.o

Relocation section '.rela.text' at offset 0x370 contains 5 entries:
  Offset          Info           Type           Sym. Value    Sym. Name + Addend
00000000005c  000c00000013 R_390_PC32DBL     0000000000000000 purgatory_sha_regions + 2
00000000007a  000d00000014 R_390_PLT32DBL    0000000000000000 sha256_update + 2
00000000008c  000e00000014 R_390_PLT32DBL    0000000000000000 sha256_final + 2
000000000092  000800000013 R_390_PC32DBL     0000000000000000 .LC0 + 2
0000000000a0  000f00000014 R_390_PLT32DBL    0000000000000000 memcmp + 2

Relocation entries of purgatory code generated with gcc 11.2
------------------------------------------------------------

$ readelf -r linux/arch/s390/purgatory/purgatory.o

Relocation section '.rela.text' at offset 0x368 contains 5 entries:
  Offset          Info           Type           Sym. Value    Sym. Name + Addend
00000000005c  000c00000013 R_390_PC32DBL     0000000000000000 purgatory_sha_regions + 2
00000000007a  000d00000013 R_390_PC32DBL     0000000000000000 sha256_update + 2
00000000008c  000e00000013 R_390_PC32DBL     0000000000000000 sha256_final + 2
000000000092  000800000013 R_390_PC32DBL     0000000000000000 .LC0 + 2
0000000000a0  000f00000013 R_390_PC32DBL     0000000000000000 memcmp + 2

Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
Reported-by: Tao Liu <ltao@redhat.com>
Suggested-by: Philipp Rudo <prudo@redhat.com>
---
 arch/s390/kernel/machine_kexec_reloc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/kernel/machine_kexec_reloc.c b/arch/s390/kernel/machine_kexec_reloc.c
index b7182cec48dc..fea6fcae2270 100644
--- a/arch/s390/kernel/machine_kexec_reloc.c
+++ b/arch/s390/kernel/machine_kexec_reloc.c
@@ -38,6 +38,7 @@ int arch_kexec_do_relocs(int r_type, void *loc, unsigned long val,
 		*(u16 *)loc = (val - addr) >> 1;
 		break;
 	case R_390_PC32DBL:	/* PC relative 32 bit shifted by 1.  */
+	case R_390_PLT32DBL:	/* 32 bit PC rel. PLT shifted by 1.  */
 		*(u32 *)loc = (val - addr) >> 1;
 		break;
 	case R_390_PC32:	/* PC relative 32 bit.	*/
-- 
2.31.1

