Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07603246778;
	Tue, 26 May 2026 09:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779787472; cv=none; b=toz9v64MqmCY21Dm9nMQH91BI6OO3mxyZ5sz/jv8gkbucEBKB7khtkCYafGeR7MvuSnfPyCp27GlGBrtCRW6L/czohgk/JHPb0m8UnhWm3RHORA0qjnF5fcuDSqeb2CazR/cGEzZ2ws3n8aHbXEBrJK/HhmFdVKujPFZsvp6UWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779787472; c=relaxed/simple;
	bh=AslCWS3RagV27E2krTplEE0YKRgiFoltEh0GO/nUaRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Il6yy1SoYRNe+5CvJZVYtc8/gs0eVjC3fa/pTjyA+CvWE2Y1VinUaCf8/RBQZmjEwD8Q58W8XnFNwToLLYhbWlu/qq89Nk7rpTTRiZcusqfIa2XhcPAlgbpDi+0BBDptme5CpE/dcvW7t+3ifEnZjbgQ2zVbeMW5n+1XRsplq8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YWZl5bsN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YWZl5bsN"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64PHsgTM3922202;
	Tue, 26 May 2026 09:24:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gtlnC1
	ZNn+wN+LpVBqdtFKL/3z5YBrSxY3QlFKjHCAQ=; b=YWZl5bsNBnOxJoNP6aVGV/
	GMByrEmnsICQC0k5lnZNv8/wt5twJ8y5bDAwJsMInvNLczJMtToQkMLfpnqb7to+
	nh3bqexG8bxg3PQRoZFD7q3bPpDAzbl/t8JRGn8Fq8XnhQ2nZzz6Xu3+ABkw85mV
	318bpVNE23gvuEVB6TiGTWN+hX+b0kykrIITIQnHA/5WRrpyd7loMNvUoyqNFSoM
	TP3DUfbwRViv36iVFOJTgNG4crcp3YgMlPrr1MVXtkXLoOBwLlGeVP297pahIfYT
	tYtqveWLDVZj2S3GItKyEaUPVjr75xk8ZROQ10SqTP8WEAyu+rHov4J5zDUdzA0A
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4nukd2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 09:24:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64Q9O5LC000592;
	Tue, 26 May 2026 09:24:05 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ebpjq8tuh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 09:24:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64Q9O1LW51118520
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 May 2026 09:24:01 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5882A20043;
	Tue, 26 May 2026 09:24:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C0F420040;
	Tue, 26 May 2026 09:24:01 +0000 (GMT)
Received: from [9.52.217.250] (unknown [9.52.217.250])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 26 May 2026 09:24:01 +0000 (GMT)
Message-ID: <09374d76-07fc-4b12-a0a7-94de4bfe595d@linux.ibm.com>
Date: Tue, 26 May 2026 11:24:00 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next] s390/ism: Drop superflous zeros in
 pci_device_id array
To: Breno Leitao <leitao@debian.org>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
Cc: Aswin Karuvally <aswin@linux.ibm.com>,
        Andrew Lunn
 <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260522153010.777081-2-u.kleine-koenig@baylibre.com>
 <ahB7_10zHxM2HQWG@gmail.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <ahB7_10zHxM2HQWG@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA3OSBTYWx0ZWRfX8tdgXn8i8Kkz
 +oeF0G9VZ4QUj7slsHo1qwXkUlSCATFRG973vEGAyqQCxWMIm+Qypvg/AomENIzIxGLDVAKYLP/
 /lqv+Ieycf58gH7wzoiAfDb5lQ3knstMCP1McVRpx0zn8C3+2alb05ke34fyV2cxJjyyyMm5cSH
 pAcKl+axMQDfGP1LpSzuKz3Io/dr4EMt5X9gV/08bK4YO/4Qvc3QEDnr1bv2gcJ4fxGLGkA6nB1
 oY9vZn0X1R/6ggz91C/jghQiZPsQV2/fC+u5QO0PdAPqLVR5CEL/4+GfGzXTcld7TmTM6+TbSu4
 RHLupv2lsAUVFOhwBMa8vgB2Pv0XFrqQPg6WfD9dYMWf79aGCh40CD7ToxrrB+grB5MRPRhi0/Y
 AHwYy0faKrLrCB1xc2NkPhHbv0nurH+CEir3UW8LOPnLXCS9dDTwzCju4bCI8kJhm1zcAPStCMJ
 2NCNLgT7dVmKD4vJwtQ==
X-Authority-Analysis: v=2.4 cv=UtJT8ewB c=1 sm=1 tr=0 ts=6a1566b6 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=IpJZQVW2AAAA:8
 a=xNf9USuDAAAA:8 a=VnNF1IyMAAAA:8 a=edyCz4FVGJroy-f0aeMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: Wl11F0PSjV_tVFJZPbAUVsVEU-Xr3sr2
X-Proofpoint-GUID: p05R3Vh-EdEOGkLB3QmECGrri4S8d85T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-26_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 adultscore=0 clxscore=1011 bulkscore=0
 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605260079



On 22.05.26 17:54, Breno Leitao wrote:
> On Fri, May 22, 2026 at 05:30:09PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
>> Subject: [PATCH v1 net-next] s390/ism: Drop superflous zeros in pci_device_id array
> 
> Nit: s/superflous/superfluous/ ?
> 
>> The .driver_data member of the struct pci_device_id array were
>> initialized by a list expressions to zero without making use of that
>> value. In this case it's better to not specify a value at all and let
>> the compiler fill in the zeros. Same for the list terminator that can
>> better be completely empty.
>>
>> This patch doesn't introduce changes to the compiled array.
> 
> True. For a `static const` aggregate, omitted members are
> zero-initialized per C99 6.7.8, so dropping the trailing `, 0` and
> collapsing `{ 0, }` to `{ }` is a no-op at the object level.
> 
>> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
> 
> Reviewed-by: Breno Leitao <leitao@debian.org>


Acked-by: Alexandra Winter <wintera@linux.ibm.com>

