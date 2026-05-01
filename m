Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3F33F1676;
	Fri,  1 May 2026 16:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777652553; cv=none; b=BegVPhVuOS1KT4oWHFOGZ4rFn/A1BMHB71hfVGJ9dqauvvUmbsVsLdlfndj/g6EKcZs8yT99s68LXOezzR1NkFHrzirV9AuWUDCIb8KYnP2gsyDvjhyWBxXthVNkHqjCju9KpRWpJBYDwD7TAo5aYNdwi9xkqEwU7SRMoRaKVys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777652553; c=relaxed/simple;
	bh=0uA9mmDO3a3D031b1VwXLb+QkTCL9HZ5iatScbCPe5I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gYpdM2nS6EMjvkTYgIAYd1h+8VgOOZQ3g5ojkg5oVtfUTMIrSvOyxlXBSWtoPPWyNk9/B7FYtPHNJSQQETwgiPawqsl/y4mvfXY4Luknm3+b4WZ4ZAcviyBIX+KC054E2PbjNN4ZTWp2xWwcrkNiShTtdd9GR60XJ7i/ELdomSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D/RdPBan; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D/RdPBan"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6411C7mj3636208;
	Fri, 1 May 2026 16:22:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=tE9Hrt4rlvBk4jAnl2TfeHoNpuq7DA0ZvVk/YsMIFr0=; b=D/RdPBan
	Gfi554Lo606DfTTl2Gs8e+OZsKFc/8+c61OUjxw8zo9zya2rY7xCbqysp/VKfFo9
	pTExj3QxnC9Tlbe8lKxcsbeWqbF1upAgIjtpFlAZk0lHGKwEf6s5/brz6XrEI2QD
	HdGtvwmUZ1ny2yZO+8PP53TxD4233JFP6T4VwpF929erueAMBVrOUQ04H21eM1Qq
	a0XXymP0ocFhZX8lEG9Rs8Zav1FNIdBaj0XmpIgkjZ6xKQosPBXYpnNNmofQJGPy
	quaOtQq4wkC3IU1zmRdTRWnTk9gBFLOoY/XoIKkwUnZkrjQqCjSyCdQY7rGAua4X
	ELLtrg47O6JvKA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drm1ebdgh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 May 2026 16:22:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 641G8in0017158;
	Fri, 1 May 2026 16:22:18 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8xkg45s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 May 2026 16:22:17 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 641GMETR24379834
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 May 2026 16:22:14 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1BF532004B;
	Fri,  1 May 2026 16:22:14 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F35B920040;
	Fri,  1 May 2026 16:22:13 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  1 May 2026 16:22:13 +0000 (GMT)
Date: Fri, 1 May 2026 18:22:12 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 7.1-rc2
Message-ID: <20260501162212.806358Add-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WFXhqV43AzXy0jLjbINH4lHYDwNFsA0d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAxMDE1OSBTYWx0ZWRfX+i0xbX2LPfPa
 EHLTtxxrThalHRrkT/fayy7rjIQ4jX7ZApT7LuSnh3jvEa4BFGeH4m46O2Il7VXGka3LNyEKjER
 /OwL1qRkDj3BSx+En4VRX/bCkhzdS3h74qvxjzV3oCD7sMZyRfV7jJ89QI1WiVy5qyu2KR4rlrW
 yaOGfyvimURBx5r40o5gsNiHjLfxBAMKJFwr2EzFCMNrhjy+SpLmVwByH4hpCb1C4wcUVC4kAQ9
 tVksPilxyiuF1riW5R+7FVNfdeoTKwooccuRbvk3tDCZJ57fxYPmjhJVW/53VZ/xGfjXyJdNrX0
 HpTj4mT9nn5IbJlt1XXXyr/GvCzwVpSywtInxXIUNgiWFJd2WK/EUgvHIXaJXzHhqPRwftlcXRA
 4UaccFfzgyxoZg4SgkKYYdkrIXJcoDmQi6M5wafZHriPnSfRY8+ab3Blonpx3zeRusL+iyaY/S9
 m0BXno0GBJeXlBRfpeg==
X-Authority-Analysis: v=2.4 cv=VZLH+lp9 c=1 sm=1 tr=0 ts=69f4d33a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=w2vx76Yw_b5U6ZZcdpUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: WFXhqV43AzXy0jLjbINH4lHYDwNFsA0d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-01_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605010159

Hi Linus,

please pull s390 updates for 7.1-rc2.

Thanks,
Alexander Gordeev

The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.1-2

for you to fetch changes up to b95e0e792822bad8fc9eb33ea3a90005e29e75e9:

  s390/mm: Fix phys_to_folio() usage in do_secure_storage_access() (2026-04-28 14:45:03 +0200)

----------------------------------------------------------------
s390 updates for 7.1-rc2

- Reject zero-length writes from userspace that corrupt
  Debug Facility buffers

- Replace one s390 PCI maintainer

- Remove SCLP_OFB Kconfig option and enable the guarded code
  unconditionally

- Replace incorrect use of phys_to_folio() to virt_to_folio()
  in do_secure_storage_access()

----------------------------------------------------------------
Gerd Bayer (1):
      MAINTAINERS: Replace one of the maintainers for s390/pci

Heiko Carstens (2):
      s390/sclp: Remove SCLP_OFB Kconfig option
      s390/mm: Fix phys_to_folio() usage in do_secure_storage_access()

Pengpeng Hou (1):
      s390/debug: Reject zero-length input before trimming a newline

Vasily Gorbik (1):
      s390/debug: Reject zero-length input in debug_input_flush_fn()

 MAINTAINERS                     | 2 +-
 arch/s390/kernel/debug.c        | 8 ++++++++
 arch/s390/mm/fault.c            | 2 +-
 drivers/s390/char/Kconfig       | 8 --------
 drivers/s390/char/sclp_config.c | 6 ------
 5 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2fb1c75afd16..b778c584bea5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23521,7 +23521,7 @@ F:	drivers/s390/net/
 
 S390 PCI SUBSYSTEM
 M:	Niklas Schnelle <schnelle@linux.ibm.com>
-M:	Gerald Schaefer <gerald.schaefer@linux.ibm.com>
+M:	Gerd Bayer <gbayer@linux.ibm.com>
 L:	linux-s390@vger.kernel.org
 S:	Supported
 F:	Documentation/arch/s390/pci.rst
diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
index 31430e9bcfdd..7650f2adb5cf 100644
--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -1414,6 +1414,9 @@ static inline char *debug_get_user_string(const char __user *user_buf,
 {
 	char *buffer;
 
+	if (!user_len)
+		return ERR_PTR(-EINVAL);
+
 	buffer = memdup_user_nul(user_buf, user_len);
 	if (IS_ERR(buffer))
 		return buffer;
@@ -1584,6 +1587,11 @@ static int debug_input_flush_fn(debug_info_t *id, struct debug_view *view,
 	char input_buf[1];
 	int rc = user_len;
 
+	if (!user_len) {
+		rc = -EINVAL;
+		goto out;
+	}
+
 	if (user_len > 0x10000)
 		user_len = 0x10000;
 	if (*offset != 0) {
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 191cc53caead..028aeb9c48d6 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -438,7 +438,7 @@ void do_secure_storage_access(struct pt_regs *regs)
 		panic("Unexpected PGM 0x3d with TEID bit 61=0");
 	}
 	if (is_kernel_fault(regs)) {
-		folio = phys_to_folio(addr);
+		folio = virt_to_folio((void *)addr);
 		if (unlikely(!folio_try_get(folio)))
 			return;
 		rc = uv_convert_from_secure(folio_to_phys(folio));
diff --git a/drivers/s390/char/Kconfig b/drivers/s390/char/Kconfig
index 4d8f09910a46..7416f941e5b6 100644
--- a/drivers/s390/char/Kconfig
+++ b/drivers/s390/char/Kconfig
@@ -85,14 +85,6 @@ config HMC_DRV
 	  transfer cache size from its default value 0.5MB to N bytes. If N
 	  is zero, then no caching is performed.
 
-config SCLP_OFB
-	def_bool n
-	prompt "Support for Open-for-Business SCLP Event"
-	depends on S390
-	help
-	  This option enables the Open-for-Business interface to the s390
-	  Service Element.
-
 config S390_UV_UAPI
 	def_tristate m
 	prompt "Ultravisor userspace API"
diff --git a/drivers/s390/char/sclp_config.c b/drivers/s390/char/sclp_config.c
index 9cfbe3fc3dca..8c77e8c44fc2 100644
--- a/drivers/s390/char/sclp_config.c
+++ b/drivers/s390/char/sclp_config.c
@@ -80,14 +80,11 @@ static void sclp_conf_receiver_fn(struct evbuf_header *evbuf)
 
 static struct sclp_register sclp_conf_register =
 {
-#ifdef CONFIG_SCLP_OFB
 	.send_mask    = EVTYP_CONFMGMDATA_MASK,
-#endif
 	.receive_mask = EVTYP_CONFMGMDATA_MASK,
 	.receiver_fn  = sclp_conf_receiver_fn,
 };
 
-#ifdef CONFIG_SCLP_OFB
 static int sclp_ofb_send_req(char *ev_data, size_t len)
 {
 	static DEFINE_MUTEX(send_mutex);
@@ -143,11 +140,9 @@ static const struct bin_attribute ofb_bin_attr = {
 	},
 	.write = sysfs_ofb_data_write,
 };
-#endif
 
 static int __init sclp_ofb_setup(void)
 {
-#ifdef CONFIG_SCLP_OFB
 	struct kset *ofb_kset;
 	int rc;
 
@@ -159,7 +154,6 @@ static int __init sclp_ofb_setup(void)
 		kset_unregister(ofb_kset);
 		return rc;
 	}
-#endif
 	return 0;
 }
 
