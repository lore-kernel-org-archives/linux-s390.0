Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C2A27AC3A;
	Tue, 16 Sep 2025 13:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758030493; cv=none; b=MxReaY8V8VbrpPvn/V989DZeMvY40GZIAdSh7b0YiyMTWzVUVze0BS18vSg2c6CvMwycECvu/DXcXhGGuDUrMEMPzbL+w2mpGxWsd4qYY5Zqu+VJ+owkrKrWxL4qi9sAiC3sxwCWzzZ2uqQFD8lkppmz9rmnsjn8vDq36BFrPjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758030493; c=relaxed/simple;
	bh=mIChQADrFvdeJeu6DZWUfpZDBh1EvHHrnubKVsPHeM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FamaUvwEEwmXure+AM1R4AqQJ7kusziC5EDONqk+zfIc6L68dM7+tAD1/6E0vjY1+/39nMeCtgw/Fl1N/Qbg6cbOOhxUUncv/UT4eoL7+3/lOV0871S5pHV09pBV8EPklLXW8R1hb7mbjgqeI9kzNfNHpFg4pEwxREozsydYofU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Cfrs5IVE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Cfrs5IVE"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G6qmNL018974;
	Tue, 16 Sep 2025 13:48:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=reeu1MIHKddULkd+G
	dt4BuS/g6bvl9+/e+R2iL9I4SU=; b=Cfrs5IVE38znnBzZC/wxpgsoCJ+/vq7t6
	BOEtB95l0GgmnPueJQrg6jtL6mlupMZmr3qptuUH9Rnmei/otM1xX+Mjwrp4homJ
	ZPI9C39jBuToRDjFa4XETiOLHF0V6nH/PPKJhPcUTYtKR2pGEyQ7Ep691qD75f7L
	DDj8muVXQU3F0ayIfiKoDmyofQLlNahYd+akg0KCR49bNvYL8g2rzODvkWq1//bI
	OD+a6yn/aavBE70QkPFcGtPB3ag79mRYsaPTNWXZrPpc9IhjwnIkK0J+EQIAY5ef
	EaavRih34oT763/Ws5teHivyimvIwoTjVda6n7GpfNW2AJYI4g/uw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 496gat7w7g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Sep 2025 13:48:09 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58GDZGRZ028246;
	Tue, 16 Sep 2025 13:48:09 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 496gat7w7b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Sep 2025 13:48:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58GAxdh2027308;
	Tue, 16 Sep 2025 13:48:07 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 495men41mj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Sep 2025 13:48:07 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58GDm31c31982216
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 13:48:03 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF16E20040;
	Tue, 16 Sep 2025 13:48:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DC772004F;
	Tue, 16 Sep 2025 13:48:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Sep 2025 13:48:03 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Nathan Chancellor <nathan@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
        Kees Cook <kees@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH v2 1/4] s390/bitops: Limit return value range of __flogr()
Date: Tue, 16 Sep 2025 15:48:00 +0200
Message-ID: <20250916134803.874580-2-hca@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250916134803.874580-1-hca@linux.ibm.com>
References: <20250916134803.874580-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=BKWzrEQG c=1 sm=1 tr=0 ts=68c96a99 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=VnNF1IyMAAAA:8
 a=fcVQ0ljOBxUNAZwdbqMA:9
X-Proofpoint-GUID: CHne1l8WGi79rvOeE0gD_z1W7N15LDHN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA4NiBTYWx0ZWRfX5P9II0ZRgxIg
 yuT8Y5ZgK0VpyfBzfZlzv5PsIO6egJXrfrAd82Rw4lm5lTg8a7W7veu4ehopoRzOwH2OVpk4xU8
 CvZDByhSj9VZr1WsIqdL/O2/tGJc9lvNjZEdoAUJTKJJfmNENe5XYpZpDMlAmW3A+G3um08t35l
 WPu5CSKj+MeKpr/cqxcq6hffoUy7AN/jt/q78KmKknaLnKopNhsKUj5QvmmW+aVEJkpmYyIPEKi
 dBz1zZcUkYm23QT5FywaYaPa3jAP+f4SwBsJBo83SwX9gXIDFgGlCxSItLGnpbaf/9GWTiK0Aiu
 OyWiBqugl1bhzE2V3haYkZKvN/ShfGLr181RmA1aVqm7UaPzgjFOFu6pdL5QbIp5LU4LmAQRL81
 FTmQvHYj
X-Proofpoint-ORIG-GUID: iyNvvkpR4w7dbz-KItc5tkMEf6y6poTc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509150086

With the recent ffs() and ffs64() optimization a logical AND operation was
removed, which allowed the compiler to tell the return value range of both
functions. This may lead to compile warnings as reported by the kernel test
robot:

   drivers/infiniband/hw/mlx5/mr.c: In function 'mlx5r_cache_create_ent_locked':
>> drivers/infiniband/hw/mlx5/mr.c:840:31: warning: 'sprintf' may write a terminating nul past the end of the destination [-Wformat-overflow=]
     840 |         sprintf(ent->name, "%d", order);
         |                               ^
   In function 'mlx5_mkey_cache_debugfs_add_ent',
       inlined from 'mlx5r_cache_create_ent_locked' at drivers/infiniband/hw/mlx5/mr.c:930:3:
   drivers/infiniband/hw/mlx5/mr.c:840:9: note: 'sprintf' output between 2 and 5 bytes into a destination of size 4
     840 |         sprintf(ent->name, "%d", order);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Add the AND operation again to address the warning.

From a correctness point of view the AND operation is not necessary,
however there is no other way to tell the compiler that the returned
value of the flogr inline assembly is in the range of 0..64.

This increases the kernel image size by 566 bytes (defconfig, gcc 15.2.0).

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202508211859.UoYsJbLN-lkp@intel.com/
Fixes: de88e74889a3 ("s390/bitops: Slightly optimize ffs() and fls64()")
Suggested-by: Juergen Christ <jchrist@linux.ibm.com>
Reviewed-by: Juergen Christ <jchrist@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/bitops.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/bitops.h b/arch/s390/include/asm/bitops.h
index 56376b6ff809..a1dd72b16f54 100644
--- a/arch/s390/include/asm/bitops.h
+++ b/arch/s390/include/asm/bitops.h
@@ -169,7 +169,7 @@ static __always_inline unsigned char __flogr(unsigned long word)
 		asm volatile(
 			"       flogr   %[rp],%[rp]\n"
 			: [rp] "+d" (rp.pair) : : "cc");
-		return rp.even;
+		return rp.even & 127;
 	}
 }
 
-- 
2.48.1

