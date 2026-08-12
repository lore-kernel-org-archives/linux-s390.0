Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDA43B2FDB;
	Wed, 12 Aug 2026 11:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786535515; cv=none; b=ML47pW1gER6UxS9mVkU2a9Gg9PzuYbC7mGMAiWMa4rZHW4eOy25uolM8AFEiq9/7KBItsdPmUSpy5HB5h5aYoT3WPpCQ0QqpyzM4w1WZXlCRnb+4JIjtCqYrfXWArPJ8FJDkuHmCVhPVrK3SqjCexlymLyYcsCw7wtSn/ajfd3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786535515; c=relaxed/simple;
	bh=W5MatxeU4F6H6TzgA4DLT206W/07XFUHuTfFhE3UcL0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d5XeO+eZzfASSyXpsWUK88E5DllKc4hZ6QXl1YaQ2mNVsSOOmV0oruAk4xl/wGiBdqVTYiB/jtoPFxtaOEskvVJwbpoYJpemPSYb3EPdD5kU4fjfu7iD8VOnKDyGQP6onND2M+gTeCKtrcIZ9VSJUZXoTIuTDsOCyKj0TFKciFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KXLZYCJt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KXLZYCJt"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CB3XY91433839;
	Wed, 12 Aug 2026 11:51:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=KeegMlqFtU+h5Jq3uj2/OERZDPlC
	Y7jKNoXMh0Xa5ls=; b=KXLZYCJto1FZGQxDfscrm5wfteaYo4w3NXhue7uzuguy
	LRPsy0ww0po2iB5anSSQ67Pe9QycDlUCQ845bKLN1xKGBj/5xechuyImlc1DRHCU
	LNCUrwpRFdgTnLpzEUD9GL8nPqZ1vN+ggfNuXw12ATEkLGdcH5TKO6OEcqBIEoEx
	co/fgqkl87yXQRdwq+G4fMDjUalRw4sfEDvvpLg0HVHhJJUcWTz3Kdm3cVFQRb8O
	f0XZ4U7d7UvDyMzHSICz37N22SDtlUpPYjy31Uaox7HT3C9+22zgWI/BGp+nixfF
	wGNxCBFFJr7xQ71wXR/TOlMU+8LPaeL90S4GevRQNA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvk026nx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 11:51:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CBfHKR021688;
	Wed, 12 Aug 2026 11:51:44 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5w5wxd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 11:51:44 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CBpgTI18350672
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 11:51:42 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B4DEF58043;
	Wed, 12 Aug 2026 11:51:42 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97F3E58055;
	Wed, 12 Aug 2026 11:51:40 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.9.29])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 11:51:40 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v3 0/9] s390/vfio-ap: Fix bugs in vfio_ap device driver callback functions
Date: Wed, 12 Aug 2026 07:51:30 -0400
Message-ID: <20260812115139.576303-1-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA5MyBTYWx0ZWRfX4+zymMexuaWV
 c9IbACj6ew8l7x1UOxHlJxSwvejT3P0olinU/aH054JB8Y1ilKWA1UzEiYBdpOzZw5RUc9Vkv+A
 zLOv5tnjhC7Ng3DCghHi8eKwuEVPwcxyw1racivUnRC0ejvK4zygQTUQY1cWiAAwDeaBg3j6srH
 DQ1TVNg1xfeYloiYyQjnH3D1JQIq25hFpZ1to34st+3J6xh3WZIFRJjiaWhwcP5KbaWXFzQsJ5x
 U5U5mqmgcci3xQFWIs9Wduc338Qzxh5Wai+ihdwLj0SCGkUeegkDKVC70zXv1+YyNiliCiVa4AC
 KGxOhX+v028AS7D0CJH8BN55nSSPCmv8WQAW2ejykQVjsaZeXPG5Qc0/vcklwnGZKBVlnz62s9z
 ALd4jC1tLxtLyCP9mbtgyWU4fsVThQFEdDyO5yeoR/MJPyIjBOmzXNvRHp4KiL0OfxlRTzHwX+7
 PoyKgbR3OC30NctVT8A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA5MyBTYWx0ZWRfX8MC6PXKD4uqG
 DpQf1y23dfFsInvJbffIKzCk0EBtPewYcGRfKUmUFfr3aoCR8ZOCmhZJ9E0bY2Z47Ql6ViMOxKQ
 09T0bH8RZEd7FQKcaFTkYNcdRVZ6Tyo=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7c5e51 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=2VMihLRbVI8WZz-xW9AA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: PMEZPElwQpK3soZIjm3TfetM3iokvg8V
X-Proofpoint-ORIG-GUID: PMEZPElwQpK3soZIjm3TfetM3iokvg8V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120093

During review of patches by the Sashiko AI, several pre-existing bugs were
discovered. This 9-patch series fixes those bugs

Change log v2 => v3:
~~~~~~~~~~~~~~~~~~~
Patch 3: Fix use of wrong lock in mdev probe function
Patch 7: Fix required lock not held during display of sysfs status
attribute 
* Squashed these two patches into a new patch entitled "Fix missing lock
  required to access list of ap_matrix_mdev objects"
* Added two new patches that fix pre-existing bugs:
  ~ s390/vfio-ap: Fix NULL deref in status_show() during queue probe
  ~ s390/vfio-ap: Fix memory leak when queue removed from host AP config

Anthony Krowiak (9):
  s390/vfio-ap: Fix stale do_remove flag across iterations in
    vfio_ap_mdev_cfg_remove
  s390/vfio-ap: Fix dereference matrix_mdev->kvm without checking for
    NULL
  s390/vfio-ap: Fix missing lock required to access list of
    ap_matrix_mdev objects
  s390/vfio-ap: Fix required lock not held during update of
    ap_matrix_mdev object
  s390/vfio-ap: Fix control domain removal in vfio_ap_mdev_cfg_remove
  s390/vfio-ap: fix potential use of uninitialized apm_filtered bitmap
  s390/vfio-ap: Fix hot-unplug skipped when last AP adapter or domain
    removed
  s390/vfio-ap: Fix NULL deref in status_show() during queue probe
  s390/vfio-ap: Fix memory leak when queue removed from host AP config

 drivers/s390/crypto/vfio_ap_ops.c | 110 ++++++++++++++++++++----------
 1 file changed, 75 insertions(+), 35 deletions(-)

-- 
2.53.0

