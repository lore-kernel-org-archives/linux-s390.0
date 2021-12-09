Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC2EC433F5
	for <linux-s390@archiver.kernel.org>; Thu,  9 Dec 2021 07:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233891AbhLIHl6 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 9 Dec 2021 02:41:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51236 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229787AbhLIHl6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 9 Dec 2021 02:41:58 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B97Rk2H004140
        for <linux-s390@vger.kernel.org>; Thu, 9 Dec 2021 07:38:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=K18KTvTYgMLK0QaoPEVXxMRVcNS+gHcgGj2Ze+jmHkM=;
 b=cfcPUVsAxOTRDFPKpESLs9fJv4YS8UMv6GLqJKu1qMbzebTn6Rwlta6enzbnax7ZmVo5
 hsiD5f7bBQWTn8ruwPV0YkLpi2WCBgB0LgXDewNdT1vkhDclfaN+ibgyeVXJ7YxDmVoQ
 ljYLhcav3Yb4jQGbIL12fulFBmoovjLIgTmPLHGeqfq+FgbqjsY394Cc5QfZYv1Gc8vA
 5sT4C6GdDcswOJ9MI3dcAnqYxRlClxa4kKGz4yTa/YdsxyTc+/0QyviHDtal7sUcztUu
 ozQkiv332XKLFSRfjcHePEk+yO8U6mwm4GYU8hhYtir6ZlECTFbk11LzBp2fNNdLJD62 tw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cudeb06k9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 09 Dec 2021 07:38:25 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B97atbt037841
        for <linux-s390@vger.kernel.org>; Thu, 9 Dec 2021 07:38:24 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cudeb06jn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Dec 2021 07:38:24 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B97WDUY012584;
        Thu, 9 Dec 2021 07:38:22 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03fra.de.ibm.com with ESMTP id 3cqyy9vehm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Dec 2021 07:38:22 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B97cJgM27066776
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Dec 2021 07:38:19 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A65314C046;
        Thu,  9 Dec 2021 07:38:19 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 677284C059;
        Thu,  9 Dec 2021 07:38:19 +0000 (GMT)
Received: from oc8242746057.ibm.com.com (unknown [9.171.4.115])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  9 Dec 2021 07:38:19 +0000 (GMT)
From:   Alexander Egorenkov <egorenar@linux.ibm.com>
To:     ltao@redhat.com, prudo@redhat.com
Cc:     hca@linux.ibm.com, linux-s390@vger.kernel.org
Subject: [PATCH v2 1/1] s390/kexec: handle R_390_PLT32DBL rela in arch_kexec_apply_relocations_add()
Date:   Thu,  9 Dec 2021 08:38:17 +0100
Message-Id: <20211209073817.82196-1-egorenar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: arnc0c-bs_y40agDJ5ovu4IhQlNihPpr
X-Proofpoint-GUID: 6lfgjIUw8Zj0lPS-PxRxEGytyoj2WfUf
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-09_03,2021-12-08_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112090039
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
Changes since v1:
=================
* Alternative version of the fix but this time in arch_kexec_apply_relocations_add()
  in order not to force every user of arch_kexec_do_relocs() to handle R_390_PC32DBL
  and avoid breaking other users with unexpected bhavior 

 arch/s390/kernel/machine_kexec_file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
index 876cdd3c994e..8f43575a4dd3 100644
--- a/arch/s390/kernel/machine_kexec_file.c
+++ b/arch/s390/kernel/machine_kexec_file.c
@@ -348,6 +348,10 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 		addr = section->sh_addr + relas[i].r_offset;
 
 		r_type = ELF64_R_TYPE(relas[i].r_info);
+
+		if (r_type == R_390_PLT32DBL)
+			r_type = R_390_PC32DBL;
+
 		ret = arch_kexec_do_relocs(r_type, loc, val, addr);
 		if (ret) {
 			pr_err("Unknown rela relocation: %d\n", r_type);
-- 
2.31.1

