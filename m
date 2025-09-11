Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F89434164F;
	Thu, 11 Sep 2025 14:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757601250; cv=none; b=QTldlfuwjz2SXiI9MqGIj650FoXYt1tSscE/UktGISh92gDRjASyfgATmvzAa4Rg2nAG0sRCDcrCu33BRN+U5lZ/57woNqs2DOCbEqt9fy34qci+uGGVzrGSVTfEhU1lFObNMHNSLDFXBpOiDb9YB5Spa9xgMXNor0vQ4AbtWMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757601250; c=relaxed/simple;
	bh=QEGJNG1D+Nc12+cx5M8B4tYE8/B1bQY/Y239GkPd1X8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KocKKKYwHo9cGWn66Zu64qqHdjj+NMvCq2BF8+2RbIaunBL5EQW8tU3SHp8s1980GoV5murlUUfWfp8RtX9wI4dl8v6Ysthh2Mh9SzsR74nk8H/e11EGllcckp0Jwn7O4VeIRsokNiB70IYuGOGkOKyCjXosNEgchFOa5ghGOWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XQBs6uKU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XQBs6uKU"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B7khkn003394;
	Thu, 11 Sep 2025 14:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=GMFutmVR/Lsu8BY5BdW6KHXYirR0i593R05VwUeBh48=; b=XQBs6uKU
	yz+0iWpdAxYQaPm2JYzWX5ETLi8qFkJknqeBjFzBZgDF4CEaD4PQrfL0pE84Maj2
	kBm7py71EICyVcXvebPZJ7QxqwJmV5tg54QZdBBHzMnxJAQgbCoZ0e0H4+zBK4XQ
	CwxlJS121iyARqF/XYepLwXGOPYa2TB7m/lKhIA9OSly9rFHIYikwaQ75fGynnbI
	dIGPkRyH6TSEKSucfFmmXUMk4oQJIswjE3DY7BuWUN+kNrwLho3xjSYg4SYtzgOY
	EGM/UvmDhf2Vm3BJifOiZJESaGa3ZZHQ0hQ4bPzfE4oTRHk8JBXuYy8+et/6lEAg
	9zmIiPpLxV8jCQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490xyda41q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 14:34:06 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58BAsVOo001156;
	Thu, 11 Sep 2025 14:34:05 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 491203p06w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 14:34:05 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58BEY20I49086858
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 14:34:02 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4736920043;
	Thu, 11 Sep 2025 14:34:02 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F59C20040;
	Thu, 11 Sep 2025 14:34:02 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 11 Sep 2025 14:34:02 +0000 (GMT)
Date: Thu, 11 Sep 2025 16:33:54 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 fixes for 6.17-rc6
Message-ID: <20250911143354.233232A3c-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jYfMomnR6n0sLf8_lMxWbcfWLblVKASG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDIzNSBTYWx0ZWRfX+kwUY4RhJFr2
 H8tfsYYDLfjjqCKiUeZE0ZgrRum26Tbf2aL8R0GPN4vhnh9iOADj07+jdMBb/kfaJkju6XqdcCW
 RvRoUkwcR3oE7//XuSvn4KJfrLi7jNoKUmhAiS9Xja8C6Aa2ogpEEgtWFMRoeneKMdJAAjFupIh
 DKpARjEZ63srv4srzUpW5SeaeabiJZUGdXxvr1XVEp9hHHuM/XEoYX9msX2p23QhB0mxoECmMp8
 3JnUbEt8XE2zOotm+Rk4+Q6557P1oHy5hpK4gYEeTKx07JGpm8hd7tVGnEqKsWJj5PFaEdgNRJh
 LQMsrPtrlQAtYfhCjR6SDjCY/HtaOJhSlt3XCo5DNrHtVJqzy5qj/uieY/MimBCwHal/Cgi0jM5
 oEQaEjd9
X-Proofpoint-GUID: jYfMomnR6n0sLf8_lMxWbcfWLblVKASG
X-Authority-Analysis: v=2.4 cv=F59XdrhN c=1 sm=1 tr=0 ts=68c2ddde cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=VtwnZtTE6dgXxh599V4A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060235

Hi Linus,

please pull s390 fixes for 6.17-rc6.

Thanks,
Alexander

The following changes since commit 3868f910440c47cd5d158776be4ba4e2186beda7:

  s390/hypfs: Enable limited access during lockdown (2025-08-21 17:46:14 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.17-4

for you to fetch changes up to ce971233242b5391d99442271f3ca096fb49818d:

  s390/cpum_cf: Deny all sampling events by counter PMU (2025-08-28 16:47:58 +0200)

----------------------------------------------------------------
s390 fixes for 6.17-rc6

- ptep_modify_prot_start() may be called in a loop, which might lead
  to the preempt_count overflow due to the unnecessary preemption
  disabling. Do not disable preemption to prevent the overflow

- Events of type PERF_TYPE_HARDWARE are not tested for sampling and
  return -EOPNOTSUPP eventually. Instead, deny all sampling events by
  CPUMF counter facility and return -ENOENT to allow other PMUs to be
  tried

- The PAI PMU driver returns -EINVAL if an event out of its range.
  That aborts a search for an alternative PMU driver. Instead, return
  -ENOENT to allow other PMUs to be tried

----------------------------------------------------------------
Gerald Schaefer (1):
      s390/mm: Prevent possible preempt_count overflow

Thomas Richter (2):
      s390/pai: Deny all events not handled by this PMU
      s390/cpum_cf: Deny all sampling events by counter PMU

 arch/s390/kernel/perf_cpum_cf.c    | 4 ++--
 arch/s390/kernel/perf_pai_crypto.c | 4 ++--
 arch/s390/kernel/perf_pai_ext.c    | 2 +-
 arch/s390/mm/pgtable.c             | 2 --
 4 files changed, 5 insertions(+), 7 deletions(-)
