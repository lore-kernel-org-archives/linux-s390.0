Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2EE3C3F6A
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 10:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787220863; cv=none; b=IScR7C8CMcn1hJh5flTFUeehXOww4jANFRA0Pz1gjpSkr8xAH0CwCVKnnuG1OlXaMCnwnRNtls80dVq7082KHfjb7XwsMttwHl0Em7bLnLGblw+d7LhKpATxxThtaKo3zkRol74u2TiNsvxU38fpoCs46ipyQqakeutblGlaA+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787220863; c=relaxed/simple;
	bh=6gHnIaPVbgFaBx2o3e0Gr0qGDFBlODq/FXqlW3wfufk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sC8l45HU1gin1fsAIFf/YSFhIlVUq9Akd6jOSo/1MoOt0HmtxLyFhK15gUGPxAehewqD/z5TbwNbTr1VBpbD1z4SWTwEImid2WNIJ/aHz4vbWgQO+1RFrdGGXx4L6iJrnASiip9mFBf/J8SW9k11b5s16QvTZabaT2dr+a+Azd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Msx0UYhm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Msx0UYhm"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K90SNg472557;
	Thu, 20 Aug 2026 10:14:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=snXhRyGevhtycw7FxA5P22eZrLmJV0jq2QbCRG46z
	94=; b=Msx0UYhmsk0y2O11rDnk1r46NOUyE7LNKeodPbZc4fyvk23guOJcvwf3+
	FubeujK7UXEPIpPUrukiXewL18AGjkuOgkqQK9D0cqkjYjQdRQW3FUGoj28k68zm
	CztdDfpZDUA3GRtnSltXLKtsI071q7NrXGz4wt1M58zP9tjY6XgnoEJ3opvLjp5L
	8QBbMyjJdadThibzwmXuho+kCmah5XxZelatH6i1Veg2rDIcUNNoV5GAZifLHNo1
	KfhRto6+cA2dKiT0gVlU+GOZ7x17wdPoFdrkyrgMlX03DElgLqjCYYXGzbF7PV4W
	BlPUg88lEmLfaqpCXdEPs4B8qx6Tw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0hk06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 10:14:03 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67KABIgT017917;
	Thu, 20 Aug 2026 10:14:02 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ngnpdj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 10:14:02 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67KADupo30867966
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2026 10:13:56 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B4112004E;
	Thu, 20 Aug 2026 10:13:56 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0880B2004D;
	Thu, 20 Aug 2026 10:13:56 +0000 (GMT)
Received: from b315lp23.lnxne.boe (unknown [9.87.84.240])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Aug 2026 10:13:55 +0000 (GMT)
From: Joseph Cathcart <josephc@linux.ibm.com>
To: linux-s390@vger.kernel.org, kexec@lists.infradead.org
Cc: eoin.mcnamara@ibm.com, iii@de.ibm.com,
        Joseph Cathcart <josephc@linux.ibm.com>
Subject: [PATCH v2] kexec-tools/s390: add --reuseinitrd support
Date: Thu, 20 Aug 2026 12:13:50 +0200
Message-ID: <20260820101350.4413-1-josephc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MthiLWae c=1 sm=1 tr=0 ts=6a86d36b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=G9HDwhCky0EsxXTtCDsA:9
X-Proofpoint-ORIG-GUID: 2eRslKVqPphDN6aNAetcuRIAEXOjpOYx
X-Proofpoint-GUID: 2eRslKVqPphDN6aNAetcuRIAEXOjpOYx
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA3MyBTYWx0ZWRfXzxRoQ0WXUXsz
 M8uiDzEURrkEouzSi8jWQ+p+5oX/5pv4E0mTCmvextEdty0FRJJbRmKz8G3UANO1SGakl4//hZi
 Ea+8L1PRcqDZ3+N0eX4rHXi0B24pIZY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA3MyBTYWx0ZWRfX6e4xZyQ2Pfsr
 ryKBE6be4x+6YS4gGBQKfsggNxLsyfT2GITYtL7+kukw5QDfny/48c0y4E+0ks1ak1qnsYS6PYG
 cQCWxVsLV473gNcTsOjcUjlQ9X4I63oN2hA27z1lETg22Us6QzKVazPrG3gPslfQ9PmvCCqY5fG
 LSnAw7xMwwvb1XXjI/oXNAIHlVVfaK+UEBW5hlJnaNLs1OU2jhy6c7iVxxX3+GERx9zj5THc3TK
 +Ccn9DIXz7Tc4k6P8oaBv9qVOhmcKsWybX9r9n2yJZiPkAlVXjEyc1AcI71TOCU38MaXJlQQH8A
 wqf1kNFQ7WhJijCvqk/1pQcPSbOW1/QNUdvEIe/0y6XPqNu+E3d3OuQSD+rrI0a+l8yWAl3fzRH
 zIdKHntBvhyYSYoX5QDm+RVg14YG416cFuOfVErwXZsyHT+XpkVP2rGppPZqEu/XiTPPOl0Wt76
 gIQK/KQmGpU79hhxeUg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200073

Currently, the --reuseinitrd param is not supported on s390. This
prevents testing kexec in environments such as virtme-ng, which by
default does not store the initrd on disk.

When --reuseinitrd is specified, fetch retained initrd memory range
from /proc/iomem and fill new kernel parmarea directly with retained
initrd base and size, rather than memory range of a new ramdisk.

Add die() cases for when user uses --reuseinitrd:
        - in addition to --ramdisk or --initrd
        - while booting a crash kernel.
        - with kexec-file-load syscall (default syscall)
        - and no initrd entry is found in /proc/iomem

Signed-off-by: Joseph Cathcart <josephc@linux.ibm.com>
---
 kexec/arch/s390/Makefile      |  2 ++
 kexec/arch/s390/kexec-image.c | 15 ++++++++++++++-
 kexec/arch/s390/kexec-s390.c  | 14 ++++++++++++++
 kexec/arch/s390/kexec-s390.h  |  2 ++
 4 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/kexec/arch/s390/Makefile b/kexec/arch/s390/Makefile
index fab3e68..17f9dc8 100644
--- a/kexec/arch/s390/Makefile
+++ b/kexec/arch/s390/Makefile
@@ -6,6 +6,8 @@ s390_KEXEC_SRCS += kexec/arch/s390/kexec-image.c
 s390_KEXEC_SRCS += kexec/arch/s390/kexec-elf-rel-s390.c
 s390_KEXEC_SRCS += kexec/arch/s390/crashdump-s390.c
 
+s390_ARCH_REUSE_INITRD =
+
 dist += kexec/arch/s390/Makefile $(s390_KEXEC_SRCS)			\
 	kexec/arch/s390/kexec-s390.h					\
 	kexec/arch/s390/include/arch/options.h
diff --git a/kexec/arch/s390/kexec-image.c b/kexec/arch/s390/kexec-image.c
index 69aaf96..a9e5442 100644
--- a/kexec/arch/s390/kexec-image.c
+++ b/kexec/arch/s390/kexec-image.c
@@ -78,6 +78,10 @@ int image_s390_load_file(int argc, char **argv, struct kexec_info *info)
 		}
 	}
 
+	if (reuse_initrd)
+		die("--reuseinitrd not supported with --kexec-file-syscall. "
+			"Please use --kexec-syscall\n");
+
 	if (ramdisk) {
 		info->initrd_fd = open(ramdisk, O_RDONLY);
 		if (info->initrd_fd == -1) {
@@ -104,7 +108,7 @@ image_s390_load(int argc, char **argv, const char *kernel_buf,
 	char *rd_buffer;
 	const char *ramdisk;
 	off_t ramdisk_len;
-	unsigned int ramdisk_origin;
+	unsigned long long ramdisk_origin;
 	int opt, ret = -1;
 
 	if (info->file_mode)
@@ -137,6 +141,12 @@ image_s390_load(int argc, char **argv, const char *kernel_buf,
 		}
 	}
 
+	if (ramdisk && reuse_initrd)
+		die("Can't specify --ramdisk or --initrd with --reuseinitrd\n");
+
+	if (reuse_initrd && (info->kexec_flags & KEXEC_ON_CRASH))
+		die("Can't specify --reuseinitrd while booting a crash kernel\n");
+
 	if (info->kexec_flags & KEXEC_ON_CRASH) {
 		if (parse_iomem_single("Crash kernel\n", &crash_base,
 				       &crash_end))
@@ -165,6 +175,9 @@ image_s390_load(int argc, char **argv, const char *kernel_buf,
 		ramdisk_origin = _ALIGN_UP(ramdisk_origin, 0x100000);
 		add_segment_check(info, rd_buffer, ramdisk_len,
 				  ramdisk_origin, ramdisk_len);
+	} else if (reuse_initrd) {
+		ramdisk_origin = retained_initrd_base;
+		ramdisk_len = (off_t)retained_initrd_size;
 	}
 	if (info->kexec_flags & KEXEC_ON_CRASH) {
 		if (load_crashdump_segments(info, crash_base, crash_end))
diff --git a/kexec/arch/s390/kexec-s390.c b/kexec/arch/s390/kexec-s390.c
index 86c9fb8..fd0d87e 100644
--- a/kexec/arch/s390/kexec-s390.c
+++ b/kexec/arch/s390/kexec-s390.c
@@ -25,6 +25,20 @@
 #include <arch/options.h>
 
 static struct memory_range memory_range[MAX_MEMORY_RANGES];
+unsigned long long retained_initrd_base, retained_initrd_size;
+unsigned char reuse_initrd;
+
+void arch_reuse_initrd(void)
+{
+	uint64_t start, end;
+
+	if (parse_iomem_single("initrd\n", &start, &end))
+		die("Couldn't find initrd entry in /proc/iomem\n");
+
+	retained_initrd_base = (unsigned long long)start;
+	retained_initrd_size = (unsigned long long)end - retained_initrd_base + 1;
+	reuse_initrd = 1;
+}
 
 /*
  * Read string from file
diff --git a/kexec/arch/s390/kexec-s390.h b/kexec/arch/s390/kexec-s390.h
index 6a99518..7e85976 100644
--- a/kexec/arch/s390/kexec-s390.h
+++ b/kexec/arch/s390/kexec-s390.h
@@ -34,5 +34,7 @@ extern int load_crashdump_segments(struct kexec_info *info,
 extern int get_memory_ranges_s390(struct memory_range range[], int *ranges,
 				  int with_crashk);
 extern int command_line_add(struct kexec_info *info, const char *str);
+extern unsigned long long retained_initrd_base, retained_initrd_size;
+extern unsigned char reuse_initrd;
 
 #endif /* KEXEC_S390_H */
-- 
2.55.0

base commit: 29898e149feb5c615b3ab6313260d58315bf1d8d
