Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071A53BFAE2;
	Mon, 20 Jul 2026 20:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784578786; cv=none; b=BGRRQ1nOWf4Jo9Axweudow+RzbBR3+O8EC7gfVhvdEY10y5qW5psMcdP/R5AyplMdHF9fgPCZtv8swKwCYJ0TjCBGbWAUp6y9KP5uRBLrJ9Fchrnp/LXLWcLRSmTTX9Y61qTZZ5LxvDxjkCEoCDuXZBsB6B/PRf82aKeXBUiOrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784578786; c=relaxed/simple;
	bh=/OjOHriBZoh8PlwsqFncb1bWp39ntoW2O6+XuqshVrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r+NwQcIQcOGGOt3gzxvJn2o8vVPe8drrcDtheBThp4K+d6Zfzg02niqaVBTwQF6XmT4fykBoTalJaaAj0/pKqyBeUyE1v2aQVEHdxEDcrdqXBvXlZvGRBgqxaSrw68hHqgYkZM8Sni7cAjWxOQId5nOWCMuA4d8aiCfmcvDTI/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Wc2bJiJY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Wc2bJiJY"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KJfms03124639;
	Mon, 20 Jul 2026 20:19:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=3gm/FgSDCIMIwPYwp
	FtqeHupXDMucT6EqhSA8P63lIg=; b=Wc2bJiJYfFQE9Gs8zX8zUP1dUrPXGitEG
	7hkuaaJFNuX6An49qQUuuMJ/DtZnw8yQbz+s9qUmLXpYZBxGzCglvc+UWtLV3wle
	ceJCnHgg3NwewXXXaecUmHw5V1Ikyy/35LQqMjZ56awk8+IGrNAuTrblOVd/fvQ2
	fTyNfu3Lr9sT+s0HDRlHXgFqZQuUCIUsPgu9f3gyAAUxhkQxJXXyKGpTB8AGQzNI
	+XqzokANkF0WrN/hmb+u0ZF18KRHA39EFMjQ1yUJQUm8Gsng9/cuFQReEVvngih/
	M/kNXASizeYUBIET216F5kkbyAedXTuo6rnFnpFesvR3UDLVbM1TQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ab9c6j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 20:19:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KKJawv018694;
	Mon, 20 Jul 2026 20:19:37 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6vyayx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 20:19:37 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KKJXSD51642676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 20:19:33 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 20C262004B;
	Mon, 20 Jul 2026 20:19:33 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 009E720043;
	Mon, 20 Jul 2026 20:19:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon, 20 Jul 2026 20:19:32 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id C050716279F; Mon, 20 Jul 2026 22:19:32 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>, stable@vger.kernel.org,
        Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v2 5/7] s390/vfio_ccw: ensure index for read/write regions are within range
Date: Mon, 20 Jul 2026 22:19:29 +0200
Message-ID: <20260720201931.976660-6-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720201931.976660-1-farman@linux.ibm.com>
References: <20260720201931.976660-1-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDIyMCBTYWx0ZWRfX5g4IBteLgxUz
 TGkGbUkvo1ozhYxP7jjfQD0Ry/ftH+x/GAckD7g4z6R2WiS6Z9BxqYLUorVQJVcTn01X+BtW86k
 t8+2DbFJabFvgLM4mZ0tPhIsmZKJoIJrzgVl7ZrWtTa1up1QtYgfyYuXF92IJEmGt1VWbNMSGfH
 KNkTGuoeTmEzDBfBlMoK0rdnBSeTgKvIyape0g6wxuxwV7Q20WbzELiC5egrr3KVc8AapRORQpc
 hqaxQ3FM2niwh/FY/6/4U8qvPKJlPDSE4Mbt8PyctrqvPMHAKl806lnaHfCs/8Ug/pnEB8zSNLl
 bRpBcV9+7xUIWQRRXdveI7i7dwSNg6CfkRN5F5JYYIh5WsEIlLay0/s2Ce+sYRNAukqpPW9KYZc
 MmzPl0NiorWZfQBnR6HZwgg4ZL8pXnHV+1DXo729MosxYeMSiZcw6ysAsdNVQ/8hL/WCA0sgorU
 /jHGyJ8mhYEOza6Cvvg==
X-Authority-Analysis: v=2.4 cv=F7ZnsKhN c=1 sm=1 tr=0 ts=6a5e82da cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=2RTzcq77zNFBleCZhqUA:9
X-Proofpoint-ORIG-GUID: jOnvINKfZTzMO-bT9Xg9Yaj_qLPEx-Bw
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDIyMCBTYWx0ZWRfX8TcR18OY3fBT
 Vk7LvE/C3BlO+NRB0UNy6oZLJpVzFh/+vDOglXoj1QDN6H5ZKaSncka6QD4eUPotLbU7xTdJW2R
 XTAPFz/qsHbsKEcG9Z1i5c6fNMErI4w=
X-Proofpoint-GUID: jOnvINKfZTzMO-bT9Xg9Yaj_qLPEx-Bw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_05,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200220

The introduction of the capability chain rightly clamped the
region indexes to the range of the capabilities itself, but
neglected to do so for the existing read/write regions which
should also be enforced.

Fixes: db8e5d17ac03 ("vfio-ccw: add capabilities chain")
Cc: stable@vger.kernel.org
Cc: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_ops.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_=
ops.c
index 45ec722d25ea..e695cd985369 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -243,6 +243,7 @@ static ssize_t vfio_ccw_mdev_read(struct vfio_device =
*vdev,
 		return vfio_ccw_mdev_read_io_region(private, buf, count, ppos);
 	default:
 		index -=3D VFIO_CCW_NUM_REGIONS;
+		index =3D array_index_nospec(index, private->num_regions);
 		return private->region[index].ops->read(private, buf, count,
 							ppos);
 	}
@@ -295,6 +296,7 @@ static ssize_t vfio_ccw_mdev_write(struct vfio_device=
 *vdev,
 		return vfio_ccw_mdev_write_io_region(private, buf, count, ppos);
 	default:
 		index -=3D VFIO_CCW_NUM_REGIONS;
+		index =3D array_index_nospec(index, private->num_regions);
 		return private->region[index].ops->write(private, buf, count,
 							 ppos);
 	}
--=20
2.53.0

