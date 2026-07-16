Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CD443634B;
	Thu, 16 Jul 2026 17:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784224370; cv=none; b=F/s1d0dP9HfS5MkiQ7CVip4cvr2ms3p0bisJyn1UZ0O7FHRJL0su7boUcYxU+KhvdcjKFtUZlLtL21OwHTe0Z7ROwjVHnS0d8dRDBPtmUdbBQKoQXCAgExg2mKwJmEYEDFzH+td19Y2T4bib6JygKSq2tElTm4NlYJXhn9xo8AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784224370; c=relaxed/simple;
	bh=sZNdI1BSDgcAuBmVpUM9hUROeSO0vtL5IlYSgOj8/aA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QHBNy03FDQkd/4H/ZFC2RMouV2Fqz+kBqEzsR6Ft2ScvBFzoJu45ZLvssfraB/gC9eE65wLDpjVXa54FM2n5325ry+axW33MkK2PGc+N79p6CIg6AEa3CzGyJHJZYPvLd5xwZRL8rp5EKCjSQkglYtrMSVdUej65Ls99kieY2l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KZegGTDv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KZegGTDv"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GGfkod3754241;
	Thu, 16 Jul 2026 17:52:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=HYX8HsCbo50LXa7sf1u3m5yiWO4eVqKpCInbBX8Ny
	Ts=; b=KZegGTDvCeMK9gPA9jqp3jGPWT+D2ybfduGPel8M1qUr5rcQSSXOJIUz1
	xxb+h+oPVWYVc8k52CHziKZAVI97FQ8M2pxQi5UwyLB8Kz4m2jqyuHWIwKHJkhdm
	0RitwdyZSv00t+0sQVjx9vd+nv5ppYTAu3ph/d8oo1mnCYjRId5fX7lJzk0xIJhu
	MGvSJjN4X8uRx5a6tIaLm7r/pEb8B8KjL2LBXkctn6jHeM7U+TVN1X01OOGrgkcE
	IQKT0aF69YNeusFw0U2eSfzpyJPznS0YfUaXgffs84YDZu3YubkFNxPN3iW+AvaT
	r5440leFZj2WkGLaCLcazGdkRqqAQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbepxt953-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 17:52:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GHncZU021750;
	Thu, 16 Jul 2026 17:52:45 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2cgny68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 17:52:45 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66GHqh9026084090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jul 2026 17:52:43 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EE3258058;
	Thu, 16 Jul 2026 17:52:43 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B3D9B5805B;
	Thu, 16 Jul 2026 17:52:42 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.248.47])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Jul 2026 17:52:42 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: alifm@linux.ibm.com, mjrosato@linux.ibm.com, borntraeger@linux.ibm.com,
        farman@linux.ibm.com
Subject: [PATCH v2 0/4] KVM s390x PCI fixes
Date: Thu, 16 Jul 2026 10:52:37 -0700
Message-ID: <20260716175241.1039-1-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cp4zkA07mAf7P0qUfr59_Tu35lzr9o4F
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE4MSBTYWx0ZWRfX4VSKE77foBp5
 HWT/MJQrzXynd7hhozTRTQ55zyjGZjosJsvBvj04Cuvdgo0pgN95r3yKvLO5/2MEIBvXxCOl9HG
 S5vuFy6B+7cZMSqfRWXb6rj5/YidCDs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE4MSBTYWx0ZWRfX5LUuQDiJQzJp
 OEUjkE8mdXu+dLGwIfPW65EhRReCE19HglxE58SvWNM/7xk7BABMPtGIzqaZHRxQsSaUVbScRhB
 ZB6aU3yh34v4hEYrZtJ3l9RElksIivrQF9ifDm0gpYiLQbu9FkFSKCZ7x5gMyElzEpZZ+IXeQZT
 7Z09MYZ6pNhy9B5lcK6xvJ0iHnX/SlUzGsCRupD9NTr2Nlol+OM+jANMNoxfdeKVLfui+DL2nKf
 MHh5QlByR/bki8vW0ocPUKcUm9Xg3cYPJnpFeqI4L3Cin1rqR93v3EZI/rKhXX+OVICKKeL2FWh
 NvH+fG89/BUvKahHAFfFDK2jKbVlbnrtjN0OuWCMYS1oW2OHVwSi3cmZeylHwcIZ6UGF500Dczd
 JMK3l4KQhseaRdEBS8WqiXk92AvLBAfBMcR8TK7LDB6b1yKH1NBcHkV5RGJWt1lux9X3TY8y9Z4
 zUWAy/IbRVauRYcZ9Rg==
X-Authority-Analysis: v=2.4 cv=XbS5Co55 c=1 sm=1 tr=0 ts=6a591a6d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=vMMF0QzAnVfWwn9IwzMA:9
X-Proofpoint-ORIG-GUID: cp4zkA07mAf7P0qUfr59_Tu35lzr9o4F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_06,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160181

Hi,

This series attempts to fix some the pre-existing issues[1] found by sashiko.
In v1 of the series, sashiko correctly pointed out some issues with the fix
for AISB/AIBV spanning multiple pages and resource leaks that can happen
over multiple ioctl calls for the same device. Fixing these will require 
some more rework and will be address later.  

[1] https://lore.kernel.org/all/20260624063447.85DF51F000E9@smtp.kernel.org/

Thanks
Farhan

ChangeLog
---------
v1: https://lore.kernel.org/all/20260713172600.1284-1-alifm@linux.ibm.com/
v1 -> v2
   - Drop fix handling AISB/AIBV spanning multiple pages.
   - Fix memory accounting functions for the case when interrupt forwarding
   is enabled by one process but disabled by a different process (patch 1).

Farhan Ali (4):
  KVM: s390: pci: Fix memory accounting for pinned/unpinned pages
  KVM: s390: pci: Fix missing error codes and memory unaccounting
  KVM: s390: pci: Fix NULL dereference on AIBV allocation failure
  KVM: s390: pci: Fix resource leak on IRQ registration failure

 arch/s390/kvm/pci.c | 75 +++++++++++++++++++++++++++++++++++++--------
 arch/s390/kvm/pci.h |  2 ++
 2 files changed, 64 insertions(+), 13 deletions(-)

-- 
2.43.0

