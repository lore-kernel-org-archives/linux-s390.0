Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76938440A2B
	for <linux-s390@vger.kernel.org>; Thu, 27 Aug 2026 12:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787832098; cv=none; b=lLTrDMq0e8EsdaOafiekG5IohInBXZKkNS2TaVsaQ6s1dtBk2CLVJf3pbVAJdFK37G6prVqBa6VcuYg2vvNBPhodf2LldHj3kBCxKxsyTuuRseAW1RfgsUpo10AY2fEHtoqCjAlS1OezD2/F+c4rC/hoYgY/Dq2LPAr+D+ctnZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787832098; c=relaxed/simple;
	bh=hJbvHNmvu/81SlvLqFg7ZJR5Q+oMn2WkbaOFyg07ovQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=al6LS/0gFv28nbQhno5yzUo3Y/0nG/9p4yO0z1VVCfkRe6180hRsPtdsj4GIgjhHJQuP51WSKN+IdlbdlRA6WZ46NB1sqKaq93GaKWYryXy+GvPgBT69WrwxCVwxN/0+EKQFx1WnQUZFLf6cNiFXJjK80AvFi19JB6pQz0qf2kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=k3rC3omX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k3rC3omX"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R9VUf82581869
	for <linux-s390@vger.kernel.org>; Thu, 27 Aug 2026 12:01:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=SS7AkrralQNVfPeJuuOYJnpbtFyiSC
	ncjFzmxL6OMdg=; b=k3rC3omXWob5dW+c3L9ss8UjT3mJEsK2rUM+43uYcAwauK
	ijGo7PBLJ9FTOHSmV74TtiUT2926HpGwoD5pHnPgCvyE/dxUvNjwI7cEPH7xxOFB
	UA4zt2a9KR3yNvSSa8Kll3uYHvLM24EdZdQapvXP1Bz1GPLfdJU7aj4iNOkD5aE0
	wQKgHO8yedxw1i8MKHk/x8CP7K///X8Orc0rSEETW3l4W/hCHglfr3YTNWFJiUTE
	SmZaruugGoPsp5xt941E7+E6yHDE43GIgEbk6Cu/LM4SpUI5r2q3EKZJqYaERSHK
	ksE89t4zY/CBT4Cgvc9e2kSx3l70rKQKnuB3APYg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g7394d5ex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 27 Aug 2026 12:01:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67RBuJmw002144
	for <linux-s390@vger.kernel.org>; Thu, 27 Aug 2026 12:01:35 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7ragqq4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 27 Aug 2026 12:01:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67RC1VrB45941034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2026 12:01:32 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DAB1D2004E;
	Thu, 27 Aug 2026 12:01:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A364A2004B;
	Thu, 27 Aug 2026 12:01:31 +0000 (GMT)
Received: from localhost (unknown [9.111.46.147])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 27 Aug 2026 12:01:31 +0000 (GMT)
Date: Thu, 27 Aug 2026 14:01:31 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Subject: [PATCH 3/3] s390/boot: Bound command line facility ranges
Message-ID: <p03-03.gfb54656967a2.ttkffvj@ub.hpns>
References: <c00-03.ttkffvj@ub.hpns>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c00-03.ttkffvj@ub.hpns>
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5oX1eIxrB0VzchbOkyMGcSy6qjI0hz92
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEwMCBTYWx0ZWRfX9P4aQ+g+G7ct
 gZTuN9hGJV5zUnLKgqNuF/XTTo3wHOWTtE6RpnrNtqaXmSMz/hi2JqvTc56zDy8PgKiRMo7jOt9
 ToHsJjN5eGBOWmDmvPOJETCnnpkTuAJZXEzqY5imwpVkCICZ3YYiDA0VryvoO1mNnXj5zTfCAD5
 3jCYKBPH/dyXG8znNIU3f7LNrtBe0oKp+fegbP/kA/MBKcEMPhW6H8b922M0EEO5tGg+JsQ0jX+
 PBtLlerGAh2t81hyy+R6CP67le9grpcNMoDr6LY+qvYC43QfNqK0JX3mHMXCs9g3Zq2pch4VMgd
 4GiPrUz4rW3twGFpwWoEc2DAfsTfYOMLlLj5fWEIAdUNqgmnvH6bVIfETrMuM9ARsLNIomo7vWr
 vohsMDajoKcQr92bdS2XvKnlusP7EQ7EvPHXA4pjDCzNTPVJHOKc9waSHlYJBTR6h03RmuL5As2
 apBk2mRw6O10Lls3E+g==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a902720 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=YWmIUACs4lId4j9K6TQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEwMCBTYWx0ZWRfX3rwCD8M3h4K/
 BEkTI2V2jyHUAYMUMYBhkg/6HCHBh1QE3hR3b82qiSYnifrPdJeb6Yrqsmipbep25W0ndx0BHnZ
 SuBI4QwZYZk1j5fDoG9XdpqLbgIAxRM=
X-Proofpoint-ORIG-GUID: 5oX1eIxrB0VzchbOkyMGcSy6qjI0hz92
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270100

The facilities and debug-alternative command line parsers iterate over
inclusive numeric ranges. If a range ends at ULONG_MAX, incrementing the
current value wraps to zero and the loop never terminates. Large finite
out-of-range values also cause unnecessary early boot iterations even
though the bitmap helpers ignore them.

Stop each loop at the size of the bitmap it modifies. This preserves all
meaningful range values while guaranteeing termination.

Fixes: b5e804598d59 ("s390: allow overriding facilities via command line")
Fixes: 15c33a5bc9b8 ("s390/alternatives: Add debug functionality")
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 arch/s390/boot/alternative.c | 5 +++--
 arch/s390/boot/ipl_parm.c    | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/s390/boot/alternative.c b/arch/s390/boot/alternative.c
index 19ea7934b918..77e8bad560c5 100644
--- a/arch/s390/boot/alternative.c
+++ b/arch/s390/boot/alternative.c
@@ -45,11 +45,12 @@ static void alt_debug_modify(int type, unsigned int nr, bool clear)
 
 static char *alt_debug_parse(int type, char *str)
 {
-	unsigned long val, endval;
+	unsigned long val, endval, limit;
 	char *endp;
 	bool clear;
 	int i;
 
+	limit = type == ALT_TYPE_FACILITY ? MAX_FACILITY_BIT : MAX_MFEATURE_BIT;
 	if (*str == ':') {
 		str++;
 	} else {
@@ -73,7 +74,7 @@ static char *alt_debug_parse(int type, char *str)
 			if (str == endp)
 				break;
 			str = endp;
-			while (val <= endval) {
+			while (val <= endval && val < limit) {
 				alt_debug_modify(type, val, clear);
 				val++;
 			}
diff --git a/arch/s390/boot/ipl_parm.c b/arch/s390/boot/ipl_parm.c
index 8aa7639ae0cb..6d8b9d61bcad 100644
--- a/arch/s390/boot/ipl_parm.c
+++ b/arch/s390/boot/ipl_parm.c
@@ -233,7 +233,7 @@ static void modify_fac_list(char *str)
 			if (str == endp)
 				break;
 			str = endp;
-			while (val <= endval) {
+			while (val <= endval && val < MAX_FACILITY_BIT) {
 				modify_facility(val, clear);
 				val++;
 			}
-- 
2.53.0
