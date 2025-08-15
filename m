Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABFA1CFBA;
	Fri, 15 Aug 2025 14:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755267235; cv=none; b=nD+OG8C1cxmkrhrQveIEnUu7KvpLxy7khmOShmUaCnrLCFy1Ozh1g2HyrnslCDTG/Cr5Eibw5NW1zYVDnBi7DDRHBa/iD+5IJYTZ3EvF6KBtcAqhJxE/KbL8vyWP/lGgfZ0bBpFl3T2XghH8DWCLKpGoxazV9cc5/Yc7EEY8hoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755267235; c=relaxed/simple;
	bh=owKp8khZ3/434hY987Aee15l7sTapMbz56wqu0UgfC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YNcK8Hp7NOLezhKbWi5hNu0dWJMBjd99ZU5Btncl53X4AoEXuMHNKtEodjfXOb1MmiKiWGvUW5Wbx/fP6/ONAzQYvU2uDjzg2etwLh3HVDzE+h+Br+Uc1hCKzz9MPv92MFg65AdciUnH/LpQtblvIPiX0R+n5G+4Mdtg7OHPTFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qhwLGjI8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qhwLGjI8"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57FAe7ml024819;
	Fri, 15 Aug 2025 14:13:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=owKp8k
	hZ3/434hY987Aee15l7sTapMbz56wqu0UgfC0=; b=qhwLGjI8r1b9aM2/E0IzCI
	6zJiMbURwrbm2wUbMFvEdGnQzPPOQLJflvQ3hlN+PV/Zab8U9cGOHumZKZFy0h5x
	dIZgaUOywv39kk3JpZeoJFTptUeWxXeUz/JUS5sVs7z2s73Xf22EcX/J7AZBLPLW
	vJChAb1EEBydwD4eKtZ+vkjqXrFpm+XsrQK44FId7dFGtmNo42nGuPHgT5WHycJ8
	QLh0kTSSlfVF/piZmOzhILU+5+A5OMzbWKFn6RzauupxmiZhbPMETc8JYfq3wQvt
	xqodcKGUIoVS3pIG8G71+8pXRcxrT4yKOf96FQ0pOdLMYNWCC6RVBDAUajEYAP+g
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dwudqstn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Aug 2025 14:13:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57FDqP5k017588;
	Fri, 15 Aug 2025 14:13:46 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48ekc40v3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Aug 2025 14:13:46 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57FEDh2559572638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Aug 2025 14:13:43 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0AF6420043;
	Fri, 15 Aug 2025 14:13:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A525620040;
	Fri, 15 Aug 2025 14:13:42 +0000 (GMT)
Received: from [9.87.144.27] (unknown [9.87.144.27])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 15 Aug 2025 14:13:42 +0000 (GMT)
Message-ID: <a08d68e5-6fea-4913-859d-7c6f3e6a2f04@linux.ibm.com>
Date: Fri, 15 Aug 2025 16:13:42 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/dasd: Use IS_ERR_OR_NULL() to simplify code
To: Liao Yuanhong <liaoyuanhong@vivo.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "open list:S390 DASD DRIVER" <linux-s390@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Yang Xiuwei <yangxiuwei@kylinos.cn>
References: <20250814131201.230724-1-liaoyuanhong@vivo.com>
Content-Language: en-US
From: Stefan Haberland <sth@linux.ibm.com>
In-Reply-To: <20250814131201.230724-1-liaoyuanhong@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDIyNCBTYWx0ZWRfX34mGjZlDSHbc
 auOx0ZDIX2UDbQhA2eZjR7JllucwuUeGGWEx/CtzyMTTwrqem2nCH2tf6A+fw1K0Ur1saWe7Ous
 B0JhT5zrUUGWB6LwUWHX+NjddY7qis/oIokySiuthZt4G1JvDGAOA3/Bo82kjIwHZuYihyKDCT0
 mnY3pWCIF9F6hb0v2PIwnWN9VwGbXjiIBcIE5RsGU+96hnrXctqP2le/BxMWV1qMyWv/wi6Lacy
 J1xDZ/Lntj6ea915FQo7LV5CeYDUkqLXSvvMrQJupi0Ix7oaTC/YXxlEjHrUfUIVkwygdyVrNze
 9m1TQDineGrI083xk0X/FUQzsHpm6Fypvi9TeF/gIF1PienrjrR1F+ng0wVzZQBu5h3y7UPXDDl
 GjXimsqn
X-Authority-Analysis: v=2.4 cv=d/31yQjE c=1 sm=1 tr=0 ts=689f409b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=1WtWmnkvAAAA:8 a=J-4uBMWTTScMImwlSVwA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 94ncwvRzWzi_KKUTE91EyKtMqWMlhdZ6
X-Proofpoint-ORIG-GUID: 94ncwvRzWzi_KKUTE91EyKtMqWMlhdZ6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508120224


Am 14.08.25 um 15:12 schrieb Liao Yuanhong:
> Use IS_ERR_OR_NULL() instead of the original !xxx || IS_ERR(xxx) logic.
> This will simplify the code and enhance readability.
>
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> ---

The exact same patch was already submitted by Yang Xiuwei <yangxiuwei@kylinos.cn> before.


