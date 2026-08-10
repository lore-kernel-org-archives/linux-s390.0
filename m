Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF4737C0ED;
	Mon, 10 Aug 2026 08:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786351243; cv=none; b=CC28JkkO6H+9WY0+TQ45E0NGocITbuO6vwc8rTz6BPlAdw1YBD1kOxBncrtyolEtc9Zi3KoXFzOVGqPXW42cNMTSAuvkkWwk32YuXbeFLym4e1bzbIE5qqjFJZrqFSl5HfK0469uQR3RYV7qwKyBB6FIf/z4n3DwVTwYaRWLUSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786351243; c=relaxed/simple;
	bh=bYUfNqyfK8CzOi2G0Po1fgIbUBfiIDkgnDMKXGO98II=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZdHJDg/0IpG0CDWP0+jdjqDXnKLhaywttg4hmlTfth3Lv96MqDRNjXC5DwMUqiEeJ6VbS2sBTBb01NpNCyFiy1c5hxrwenbQj7DTuTUrKvJE6r4vYgeiHCQ9dP4U3/30C9i+Fi5I0VBnW3SNJUTC6zJRnfsdzMV6nEutLH/CUGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fRSeCybU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fRSeCybU"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67A5VWv0710520;
	Mon, 10 Aug 2026 08:40:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kD5iOW
	hWrT9fqtA7BznpteUf5AZ3qJM3sZBF1XnikIs=; b=fRSeCybUzsNANo6osoGWsT
	AC8ysTGYKSRhzsl6KBxH+RlKg61P+8SmbnHCIhmavZ+BuxYyZURdBtecoFWj3LiH
	gBPSFm0LeSmcBgpELoF/Crhoc11M5yJs39ckuUz2/GvALDqu285jQIu/HLL2ty9m
	DayEEzPqURVksephBYUAhP9dE59LOTrGohenk1fpiqaLkHgcqaclF4wDxybny7OQ
	7eMBVF9s4jS1omlhqgTE81H+RJ2gvUyTvmQGZtSifm/o7Mj52AciXx+HdrIChBAN
	2FwMosiwoP9kEElgD2szWCURqH9fGeuycErQGEQkSpDa9qSEyuQf2kK5alOMvsmA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq970ux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 08:40:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67A8QJlU009884;
	Mon, 10 Aug 2026 08:40:37 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsjm16v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 08:40:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67A8eXFH24314382
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 08:40:33 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 927BA2004D;
	Mon, 10 Aug 2026 08:40:33 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 360FF20043;
	Mon, 10 Aug 2026 08:40:33 +0000 (GMT)
Received: from [9.111.39.9] (unknown [9.111.39.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 08:40:33 +0000 (GMT)
Message-ID: <2ad8cca8-7d73-4de5-986b-f9ddfe425b20@linux.ibm.com>
Date: Mon, 10 Aug 2026 10:40:32 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] s390/ap: Drop unused member from ap_device_id
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
Cc: Harald Freudenberger <freude@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
References: <20260806155757.1281233-2-u.kleine-koenig@baylibre.com>
 <55aa5d3b5b1794b5fca7f3ae75b48dcefa09e808.1786033091.git.ukleinek@kernel.org>
From: Holger Dengler <dengler@linux.ibm.com>
Content-Language: en-US, de-DE
In-Reply-To: <55aa5d3b5b1794b5fca7f3ae75b48dcefa09e808.1786033091.git.ukleinek@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 97G4PMSrERzYxtojdU6BBSb_7MfsL2JP
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a798e87 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=IpJZQVW2AAAA:8
 a=VnNF1IyMAAAA:8 a=4MUW6suwNLsLzSb1ENYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDA3MyBTYWx0ZWRfXzPRFRVw30TN1
 kd+0brfGZ9rU1nM1GMOPcvHdY0EKUKqU1wIbGefw9NsI97zb6GzlcKjk7X7vtxs82W5UemcLvJB
 kQi0bvlDxaYMNtbnt4R3Ge0ESS0veg+Lpg9FIqSkywT1HCXe4iIniRs8VBP45fp2cNbHlPtfjdL
 ZkAcu5HYB60i2HQzfwaoFDgTK1Pz3g2GIBEisDGbBDGEnmtjOoZt6RYPBZ54mghgdR4I3CfmpjO
 llqXjQ0yb6t6bsab8pv7NgcSr9HMS6UfBqI6KhuwShdIyJ98ZpJngxu0w6buOombyPBtDG4sJr2
 BK7/lI2z6Rm1prpdzPf9ClN0OxTHQQhP/AQuizvOEMJaNLTHMYn73B4o4Kvaa/FrAj9MLwbuzoW
 hOfXy5eEOFZKqr4h8/ShdQVDK3xB702F5Vss/JsDctgJ8FUmnYK5u91w5QVQoQ7Bq0b/EWcN9GO
 9n2rPha4pD9yy35parw==
X-Proofpoint-ORIG-GUID: 97G4PMSrERzYxtojdU6BBSb_7MfsL2JP
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDA3MyBTYWx0ZWRfX/Jct9eapYPVQ
 xDcebVzlyipHVEHXvdtaUmv0H9OxfIVI+EIrVv9/n1YDI64jLGIWi/ijTGLYyEzxnenYRex+vES
 8HthLB+/scJKwj3vse9sVoCmkMggtuE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_01,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1011 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100073

On 8/6/26 18:21, Uwe Kleine-König (The Capable Hub) wrote:
> ap_device_id::driver_info is not used in the kernel. The structure is
> also not part of API/ABI, so the unused member can just be dropped.
> 
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>

Acked-by: Holger Dengler <dengler@linux.ibm.com>

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler

