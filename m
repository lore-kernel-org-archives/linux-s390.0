Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03316146D4D;
	Fri,  7 Jun 2024 14:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717769949; cv=none; b=RIAYeLw9IGZgURkGTRM/GUnzXdp2KhsE+Z9w84DqczK6uavADa7AYUHu3p4V3dmTvkrJtNSBKQ/+8EzA07xjWrQEy4tcM3sNY+pubrNkruC6mGgYaA2wKi5HKpXXydsfKKYEDI4EyN/PeNOFkb4L9ZeJ0q/0UpIsGjCD0hR09tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717769949; c=relaxed/simple;
	bh=dmyKBIrGJx3WWoBggWmjF0Z4ppLW8i1IhHzfkec1a4A=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=DYz1Vi0AlFZRmdM3mNZhWTCvCRBd0YRgRQL2WzMVYmj+1qu63ubzudEEb92hfChlQAAqwR5aJrAg9DUE9VPNRBSN4Kq7UZSFzNGP509RP3u7dF7vr3P36RxA5mKB/SYYn/SezrqDLAH3GYWN/Jkgc9zVyFGESI3c4cQZYn2qTuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AgL38T/C; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AgL38T/C"
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 457EGrjo031239;
	Fri, 7 Jun 2024 14:19:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc : content-type : date
 : from : message-id : mime-version : subject : to; s=pp1;
 bh=o5Ux/KkLv8VlOD1jNtlwAc2IfvsNrLcW/YitJutC2aI=;
 b=AgL38T/Chy9BzuLowVftiAxDG787rGisBqWTSfwLXHrt9VmbXcicPyGt3H6qfoBN6cFg
 kmlos0cAWOmGSVJej2hfX7R/q0uCDNzYy5sAG2CUn9HIihwiDAy/OaemsfjZL8rMqWXo
 +hYYS7szvt7a0kLlMEK5TzBL/a7w6P0PNPDO/arRVnQrLf5GiLFnvE6t4vYWiobdLzKT
 MQW/z9Uyxei8VQjiyKQZLcGU9GACuqxikEnUqsl+wkvXnvwWqfzvVimnpcwyma2qEdQs
 4Dk2Zyhh5L0c5ddYif+PJsMUSyk0h4L4CFiNSKGNACmm6Edr6CSwWET9E8gUXG1l6Swj 9w== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ym3u3r08e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 14:19:03 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 457C0haF008479;
	Fri, 7 Jun 2024 14:19:02 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ygec199va-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 14:19:02 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 457EIudx38011136
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Jun 2024 14:18:58 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D237720049;
	Fri,  7 Jun 2024 14:18:56 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B837920040;
	Fri,  7 Jun 2024 14:18:56 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  7 Jun 2024 14:18:56 +0000 (GMT)
Date: Fri, 7 Jun 2024 16:18:55 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 fixes for 6.10-rc3
Message-ID: <ZmMWz7/EN3YsRfOH@tuxmaker.boeblingen.de.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dQg7J8vEZqVu4pJj3kXSblJF0kv0OtXt
X-Proofpoint-GUID: dQg7J8vEZqVu4pJj3kXSblJF0kv0OtXt
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_08,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 mlxlogscore=889 suspectscore=0 clxscore=1011 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406070105

Hi Linus,

please pull s390 fixes for 6.10-rc3.

Please note that "KVM: s390x: selftests: Add shared zeropage test" was
supposed to go into 6.10-rc1, but was postponed due to a build error,
which is fixed as:

diff -u b/tools/testing/selftests/kvm/s390x/shared_zeropage_test.c b/tools/testing/selftests/kvm/s390x/shared_zeropage_test.c
--- b/tools/testing/selftests/kvm/s390x/shared_zeropage_test.c
+++ b/tools/testing/selftests/kvm/s390x/shared_zeropage_test.c
@@ -11,6 +11,7 @@
 #include "test_util.h"
 #include "kvm_util.h"
 #include "kselftest.h"
+#include "ucall_common.h"
 
 static void set_storage_key(void *addr, uint8_t skey)
 {


The original version bc54d7c6050e had soaked in linux-next for few builds:

next-20240422
next-20240424
next-20240426
next-20240429
next-20240430
next-20240501
next-20240502

Thanks,
Alexander

The following changes since commit c3f38fa61af77b49866b006939479069cd451173:

  Linux 6.10-rc2 (2024-06-02 15:44:56 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.10-3

for you to fetch changes up to 01c51a32dc18f128d2e55a7b2128b77fc01a2285:

  KVM: s390x: selftests: Add shared zeropage test (2024-06-05 17:03:24 +0200)

----------------------------------------------------------------
s390 updates for 6.10-rc3

- Do not create PT_LOAD program header for the kenel image when
  the virtual memory informaton in OS_INFO data is not available.
  That fixes stand-alone dump failures against kernels that do not
  provide the virtual memory informaton

- Add KVM s390 shared zeropage selftest

----------------------------------------------------------------
Alexander Gordeev (1):
      s390/crash: Do not use VM info if os_info does not have it

David Hildenbrand (1):
      KVM: s390x: selftests: Add shared zeropage test

 arch/s390/kernel/crash_dump.c                      |  54 +++++-----
 tools/testing/selftests/kvm/Makefile               |   1 +
 .../selftests/kvm/s390x/shared_zeropage_test.c     | 111 +++++++++++++++++++++
 3 files changed, 142 insertions(+), 24 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/s390x/shared_zeropage_test.c
