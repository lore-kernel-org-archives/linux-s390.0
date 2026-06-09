Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049013AC0C0;
	Tue,  9 Jun 2026 09:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780998052; cv=none; b=XLNiVSx7tPRVF1hJxJwxCvKbP9Ti4h85z7MEZzzXhv4I9Xxu6VlUgprADAynAkQHnJgZve2ti5x/C/lx4GlhBAF0IQDHZLpgS4+NcQwsuQagMKo+QocNS+yJgB0GHbGO8MIPF9zf0KhYDo5fpRiGl8DLW6oqT9cClriCpabMwOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780998052; c=relaxed/simple;
	bh=0IOB9dhUUEbltfcW9tXRtRfazKG2MQNnXvC0i4XXCSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OLr57gakUTddHrtoojEnr9Q7iCuGjlK4hlx8+zJLcYUZPnBusw8KMiQWpHwmyjIT8QCIA9oDAkiGXQWHOtWwPPOWdcKZGT8dvdy1ZPG+WWHA8bbUUT7dUd7tb1T6d5zyXmLUbGEWoA9TRMMBLBGXfOuzih8kd1WO775ws5cDLmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UsOALwdH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UsOALwdH"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6592a8pi647384;
	Tue, 9 Jun 2026 09:40:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0IOB9d
	hUUEbltfcW9tXRtRfazKG2MQNnXvC0i4XXCSo=; b=UsOALwdHn7Mp0F+/8lQaPt
	82DsTXQdZD+KLF7lV5q+xMPjIsZ4+nR0JKd0tg25RgDz5bvatTLjiQv/hq7YpX+N
	EeJKBwWvT2AOaYG90HH+HT/DmbAvICnSW0ldd8Jzzrahf69ZiGpdDdVJp82gE1vp
	Ya5gEBTByIdIx7VeynW8lmwPrMmE0jQQheaaYTihYpgtNY0OAblv5aTfZl36UPEG
	sP5+onlkeSXvBQ8/lO/C4E3GcDys/FPKiwoth2Bgjbd9hIXyw53BSDqVdYSg2xFp
	7T8Tf9lJ0wl9oBTsr16uoT5zmZ1fT8CpZD2pQ0KNw8zd2iB7QiL9IYuJnKmQ8pLQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em9ye3bdt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 09:40:30 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6599Yclm021337;
	Tue, 9 Jun 2026 09:40:29 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en0jy9493-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 09:40:29 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6599eQaX46072154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 09:40:26 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B21E20043;
	Tue,  9 Jun 2026 09:40:26 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E22220040;
	Tue,  9 Jun 2026 09:40:26 +0000 (GMT)
Received: from [9.224.76.67] (unknown [9.224.76.67])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jun 2026 09:40:26 +0000 (GMT)
Message-ID: <7d2ace86-f355-4ff7-886b-7963574b2202@linux.ibm.com>
Date: Tue, 9 Jun 2026 11:40:25 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] s390/tick: Remove CIF_NOHZ_DELAY flag
To: Christian Loehle <christian.loehle@arm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "Rafael J. Wysocki"
 <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@kernel.org>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20260609075213.31094-1-meted@linux.ibm.com>
 <20260609075213.31094-2-meted@linux.ibm.com>
 <e70007af-aa98-4870-985a-6648564127fd@arm.com>
Content-Language: en-US
From: Mete Durlu <meted@linux.ibm.com>
In-Reply-To: <e70007af-aa98-4870-985a-6648564127fd@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA4OSBTYWx0ZWRfX2qTmdA/snrch
 LIo4WceJ7ZacDar4mfwJrU/0X8ijMyzJHKhLzDA6MmbPt8ZA+HmZEAgEihSjkr6H0hlU92uk6MB
 ccZFoZsmFtn95o8oB9oaUdjr0947yXRq0dAQjvT8TpFB8lbhrASFeQBjFfoGCfHF0e6jr/uzAQQ
 ZgOtNpAw1snOYYevuRDP7PHW/ZzLnJbh8pz0I8MYolktJFjP2pPYKjNAy+jweWwbC5RCAEn7+QT
 gquNaRetL9prHclkizXr/Kr1qxg4dsOSOWFmAb583VCc57yAJzdPBG4/0lNIIoc7QNF+ufhyamh
 wRdRCn+/8AQtWoAlUSyfk34345UfoEf+70LXkuiAC/AX7H+GKu0IHDS6T1/4REduZNkJ/zaWDYJ
 FFLXGQN6KwZVwXV26p47DNIpq4tcA+m3jZxJmpJspzc0dAYAIO6eJW6XTw5ffKBUGaFCXHNqcZO
 oJr6oWyMoSBy6HmZceg==
X-Authority-Analysis: v=2.4 cv=QKhYgALL c=1 sm=1 tr=0 ts=6a27df8e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=YXXVI53-z694RghoX0MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Kvw342n65A7XLKsyf931PCQ8v2W7R9Hf
X-Proofpoint-ORIG-GUID: Kvw342n65A7XLKsyf931PCQ8v2W7R9Hf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090089

On 6/9/26 10:10, Christian Loehle wrote:
> On 6/9/26 08:52, Mete Durlu wrote:
>> Remove obsolete tick delay heuristic [1]. The upcoming cpuidle driver
>> handles frequent sleep/wakeup cycles more effectively.
>>
>> [1] https://lore.kernel.org/all/20090929122533.402715150@de.ibm.com/
>>
>> Suggested-by: Heiko Carstens <hca@linux.ibm.com>
>> Signed-off-by: Mete Durlu <meted@linux.ibm.com>
>> ---
> For bisectibility does it make sense to move this and 2/5 to the end?

I am unable to see how that would help. Could you elaborate?
