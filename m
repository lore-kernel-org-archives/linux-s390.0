Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792570248;
	b=BOj8/Dws0iixQm0EPXPjjFQMS+qvmoCWmp77qjsJPgw55NqPwtWV1HhkNxPWRMWTHHum
	 8KG1Hfq8hXT4Ot0/kx0bjuh4xWkkXnhqi4D9Lp8IUaYBE7kvB0WOiL87xjSK7MslPHZJb
	 Urihi0TTvqkQnCZTjPNEKjY2w0Rg2T2uH/WjQLduYfJgUub5uxkawEy89u8bZa1wM6lpW
	 zdwCQnYu6/43fug5HBuisZZN0x0KyCnzRXlq1e00PTpIQDRIjHovuTFCSFxUXDf7J3v+0
	 xBEvJl4CLJREFYLse7F1xPVBm3UjUGORZ/73g84+lakuOAPdrFd8znhZ/lAXMDwnD1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792570248;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=GINI7196k/jXH+/DsZHVh86VCZULp4/VdvseAuYRlSw=;
	b=LrdiRVodQydX5NDF16F2ybULg2ti1PQc1ggWdrOOL+Cj12QsZSKjJk9lx5u0OFyL60iq
	 SbpbH3KKg+46vXv1YfHdoldKoo7exMGgsMJmisqFGWXElHauswIJaV91eM4XMylNWStDe
	 mDh10xwbHYpsc5mMGBKZIIsSR+mSQn5cZwIcxUsfdRP7j0P/ttReDkiE30IU3x8rJoKYZ
	 Q/8SGmE8o78yEK9/D19j1MvwmMyAZaM4D2fnfrV7tMdUteUUhC6pf07aPkgFFR1tGSHC3
	 Xis8n2EWfYb3m8hsSt9tRJg2T8n4q1sNnoH53ME6Dzzqzd0VgVX4NC1AVcPW1XqvOKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SRujLNl9;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3272A606A319;
	Wed, 21 Oct 2026 08:10:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3272A606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SRujLNl9
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69L5iglV274494;
	Wed, 21 Oct 2026 08:10:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GINI71
	96k/jXH+/DsZHVh86VCZULp4/VdvseAuYRlSw=; b=SRujLNl9Zwq6zgz6jPKRUe
	78Nzt7L4e+7Mp0mLXrg21QwFxafbOE92AlIoIWkI/UxEy3PhbhdHJRcD5MvluywL
	f577OZ9xeaUxDwVaJaQdaZYnFTQNMjdmR1WaB/jNPCVYcNCeF6eqcvhr7bXF/TnH
	TwEJjTOVWbwEV3vvQPD3VAVCx/fxnWcOffYAk3ivqK6oYX06t3vHD3M0E/+1CxCV
	vghJVpAQhGbUcZqvo9OHQt3NVIrFj10N5ss1aahoHzQYfEqDtZLewrF5PC4KkOGr
	EhA3Y+dZ807SoKz05/ESOX6LDrAJXXD54l5zeOePr5j84IUIwA11VUo1Yk75Pl2A
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5aqgu2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 21 Oct 2026 08:10:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69L5nrWt2684260;
	Wed, 21 Oct 2026 08:10:35 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4he8vhuv6h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Oct 2026 08:10:35 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69L8AV3n41288144
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Oct 2026 08:10:31 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2BE622004B;
	Wed, 21 Oct 2026 08:10:31 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E684920043;
	Wed, 21 Oct 2026 08:10:30 +0000 (GMT)
Received: from [9.224.68.68] (unknown [9.224.68.68])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 21 Oct 2026 08:10:30 +0000 (GMT)
Message-ID: <22744f49-b45a-458c-828d-bc19a5f06aa9@linux.ibm.com>
Date: Wed, 21 Oct 2026 10:10:30 +0200
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iucv: fix lockless sk_for_each in afiucv_netdev_event
To: Haoran Wang <haoranwangsec@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <179241612354.5916.12881323209252769976@whr>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <179241612354.5916.12881323209252769976@whr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=X63Hu2Te c=1 sm=1 tr=0 ts=6ad8737c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=_eNH3aichsnAWiy1AtcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ryKGVAkseroqDH-QuvbKb0wrxGw7UBsb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAzMCBTYWx0ZWRfX+1jlpldPkb1d
 L0scCkAIQTS+ac6dnYtWj5h9yJwiNW8Z68t/CfK+Ykdfzz9KeuvL7vOGv3C3Ww70kTQUO0QzCOy
 y5Ct0PsDT79AfSD4MGIsQKcdUTt+zmzOa0ay9b3FBm04lIXsjfPrQtDEwAqCFEW2Coup1uHCAbZ
 Ed/BiCmQ7APJ1l8W1oGzxHOOzYFENNQPjDtoegbnjO88+X0NIW6SBMv4YJpSaead8cOxE8y+yZa
 nUru2PYsyjYLwjljsU9qb0C/4faN4X9yYsT2E/zk6dsQYUlmPfUnWGHxM8sJ3R/EIFOalOXcbLe
 rfZXP4i10XILgEMTgynCvSemnfDlhCEbcpKaf+62iaOcyL+c8l3gP1alhJgyQ3bkTlXgxmER1F9
 a1WWFRl/MtYhz8Drd9AYp50sIoeNhH+eSviWRRZkM+uWBpzE4K7xfgqJn7/nJducuIgZ6HHPNXr
 La6aabm2H6+dwhrfZ7w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAzMCBTYWx0ZWRfX+MnvtKtY0cKr
 I/OV2vqwvAbvPwkJofKLlICGMjXeR53iBlrzVS4WRMHgN7OTsPzM+1+Be3aBgZTroK93UxFRkpX
 aJypl89Gx8SSYI3o8JqjPtImrLFdGxc=
X-Proofpoint-GUID: nTBtUMs3YubrJjzgLYZUAXPXcWz3yfj6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0
 clxscore=1015 spamscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210030



On 19.10.26 15:22, Haoran Wang wrote:
> afiucv_netdev_event() traverses iucv_sk_list.head with sk_for_each()
> without holding iucv_sk_list.lock:
> 
>     /* net/iucv/af_iucv.c:2218 */
>     sk_for_each(sk, &iucv_sk_list.head) {
>         iucv = iucv_sk(sk);
>         if ((iucv->hs_dev == event_dev) &&
>             (sk->sk_state == IUCV_CONNECTED)) {
>             if (event == NETDEV_GOING_DOWN)
>                 iucv_send_ctrl(sk, AF_IUCV_FLAG_FIN);
>             sk->sk_state = IUCV_DISCONN;
>             sk->sk_state_change(sk);
>         }
>     }
> 

Hello Haoran Wang,
thank you for your contribution.
I think the issue you are fixing is the same that Nagamani already sent a fix for [1].

We are currently working on hardening the basic socket locking mechanism in af_iucv [2],
and I asked Nagamani to hold off until that work is done.

So I think this issue is already being worked on (please correct me, if I'm wrong).
Feel free to comment on Nagamani's proposal, as you have an understanding of the issue.

Kind regards
Alexandra


Link: https://lore.kernel.org/netdev/20260803182053.2355882-1-nagamani@linux.ibm.com/ [1]
Link: https://lore.kernel.org/netdev/20260724222917.134769-1-hexlabsecurity@proton.me/ [2]

