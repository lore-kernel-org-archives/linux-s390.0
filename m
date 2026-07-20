Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26873BED19;
	Mon, 20 Jul 2026 20:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784578780; cv=none; b=Owqz4BtQuZEDr88EA5lg5OwEkpFnWJcZU0nTEXBX5ybzxlgfE9XUgM1WfHrRmA7j5OSBbaDtzXp4aePoANEGvu0dNKGj0aXOzF+tGGOGhQi11O3gVcwuAJHbJ39ok9KlyIbDkqZbO5uDQJvw8prIFQ0f4pzXnz2f8nXU9vqV3ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784578780; c=relaxed/simple;
	bh=54sPX2xBLkiGWjK/dh7pFT0TaP0TfN5Jhxfdgwl9H0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K+MaEKDIzUd/ZRMxMED9YvTAWPTwmDPK3qAyEU0oiRMfeASKj8blQd/k5LEXP1tG4tv5+trn4W4C/42r0xChhRcjXMhafdqskmsoEkOrrUuWAlkBkZ7axR7yksy5ileuCT/GCLX0eY6W/pRIe5+V4SEnXJn1rsbJlwAVjIobZqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pazJPkUA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pazJPkUA"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KJgccq3031783;
	Mon, 20 Jul 2026 20:19:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=pxRQX4yfvDHbmiJ/K
	BysaQAz7SXKNIqErAOmcW3ynS4=; b=pazJPkUAlz+fpx6ZhukPW6O0gUsdycIxN
	XE6T8mjtvvqTR2HKSk8K1AWrYl933A1PE7CXZ32qUfTXfU9hjrHDf7tLMKgMEJ0v
	AHdjeLjTHGDZgmkEyrJnOhYXMyViQldNp5poYlL0Dhucs+HoJds+xfljQ+WcfSDE
	qoei9u2KFmxwnlttbChsLUPYdE7Z+iv5lG+9XYAfGF136k2auF8TBtylsllFTtCR
	YO1FOYAs+6XVZVEiURdivOmihcyXvwEmv0z08bCpj7WEpMYGbyYO91vqlFATP/FD
	VD3rlepAUkjbLXxxTSWuSbgHPVtaL/L9gOOgV7Eu/OYK47LjzgOVw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78g117k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 20:19:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KKJbam015416;
	Mon, 20 Jul 2026 20:19:37 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1g7173-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 20:19:36 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KKJXxh40435974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 20:19:33 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F00E720049;
	Mon, 20 Jul 2026 20:19:32 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D1ADE2004D;
	Mon, 20 Jul 2026 20:19:32 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon, 20 Jul 2026 20:19:32 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id BBE77162788; Mon, 20 Jul 2026 22:19:32 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH v2 3/7] s390/vfio_ccw: fix out of bounds check on CCW array
Date: Mon, 20 Jul 2026 22:19:27 +0200
Message-ID: <20260720201931.976660-4-farman@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDIyMCBTYWx0ZWRfX9GCO7eItBKjG
 CUq/LLmxNeUV2/h4Mkf+zZZXmT+NRiLe1mmroL4ZP21LuJhOGqb4Icr5qD3Byt7tavmUBzFQxCr
 igxt8geA1VdUZUNsnOREOHurkLh9F1laOiheFzTopp2qnDCeqdgCn1+fVwECA/Q8KfJmqbTS2H+
 uAHzYFD3XYc+sJQkm4+zo7u5Q2dhoPs6bjUspqUbdNKsHnWVRroypr9Pb2BYEN2aQAA8v5okU8E
 et8wVjDEwRa7jLbw2SP3hu32QVBj+JxmLP2jHSmOaujL+4lMRq3mFjibNKEQEAsYHoWOHBw9Fgo
 1izYihCq6zL8aMRfUDn8/xevNiF02wKmlfIshhhvBXEAXkEeUd2lom9kxj7EnbSTU8i6sFtsEZK
 iz6B/VOY7dtvBqxr2WTOjNGu524EK4mhsNra4rSr4kKg5RFn8ytvc+DsEHayadi6+vmVwmgyGkZ
 Cw5NoCy8S+QnLwvH7SQ==
X-Proofpoint-GUID: 0cJz5U8iJGrGttvGpbkohrBSySy3BDog
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a5e82d9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Ztfy0_AA8xUuwmIluScA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDIyMCBTYWx0ZWRfX2zlKfnsYuJfr
 dvI1tZnOh6hpWFMWrdRg8myvjs8Ra3WUpWJAXJP9oKQetWa2+VmI2xyDwsTeaSb80T+lDOU2/et
 rfOQS6fnSG4+Dpl23Z9T6PtD1qIrhGI=
X-Proofpoint-ORIG-GUID: 0cJz5U8iJGrGttvGpbkohrBSySy3BDog
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_05,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200220

The routine ccwchain_calc_length() counts the number of channel
command words (CCWs) that are chained together in a single channel
program, and rejects anything larger than CCWCHAIN_LEN_MAX (256) CCWs.

The loop itself is "do..while (count < 257)", and while the logic in
is_cpa_within_range() correctly adjusts between the 0-index array of
CCWs and the count of CCWs starting at 1, this means it would look
at a possible 257th CCW before ending the loop and (correctly)
returning an error.

Fix this by restructuring the loop to break as soon as 256 CCWs
(thus indexes 0-255) are examined, without looking at memory
outside the range.

Fixes: 0a19e61e6d4c ("vfio: ccw: introduce channel program interfaces")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_c=
p.c
index 7abdebd8f7c3..ce61858c82eb 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -393,11 +393,14 @@ static int ccwchain_calc_length(u64 iova, struct ch=
annel_program *cp)
 		if (!ccw_is_chain(ccw) && !is_tic_within_range(ccw, iova, cnt))
 			break;
=20
-		ccw++;
-	} while (cnt < CCWCHAIN_LEN_MAX + 1);
+		/* Exit the loop when we reach the maximum */
+		if (cnt >=3D CCWCHAIN_LEN_MAX) {
+			cnt =3D -EINVAL;
+			break;
+		}
=20
-	if (cnt =3D=3D CCWCHAIN_LEN_MAX + 1)
-		cnt =3D -EINVAL;
+		ccw++;
+	} while (1);
=20
 	return cnt;
 }
--=20
2.53.0

