Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D85D36AB5C
	for <linux-s390@vger.kernel.org>; Fri, 13 Mar 2026 09:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773394787; cv=none; b=qlnD7H4a01xIinYhB1ii44Bg/CF3H+FQEFJB5lK0doDg446WTpyZxr75NM9R6NA6BKwEjgUenP1o2twRsC7X8Rhk4jRpbJ0OQpDYLQa0BR9Jv53K7wS2W4ZJNa8XxuigIT1RSSDBVuu2TkxY1QOelXt4VWBTL3/c+kTlM5BszeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773394787; c=relaxed/simple;
	bh=g2XHWU4THIn5/SatFUcIu3HfkQLWSEjXfCE7zBRA+LU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=AhDjEdWAz4uB6R3oeeHF/UbIEbOS2SxakKovMp1BGlfLkFHWfNWRTuOeIBGdHr3HWDCbwvx8bG/spMUbuzSUFaP/Urv1cJ+i2yJbuqUHUHe52PRRUXhN2rQEb12YMRH4OSPBOqIuYnmBig8d2ognMOysok6Q+Vt1jmqBeK+pTKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mL0ljWEu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mL0ljWEu"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D4Ccx32580972;
	Fri, 13 Mar 2026 09:39:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=EtCg1g737q/U6nW11p7RIGgRa2QUIPZvBG7e++JnboY=; b=mL0ljWEuZeQw
	t4bf2jwOgdS8RnuxhzN57tMmXO44A2j/adzpPM0DrPJSxeOpww+fgDnrEg9hpWiG
	FUEtGGv5vnpYPdAuIB13hdhNJlA8kesh84lsIg+jOqIiGhMmC9UhMEukEam4i+iE
	RTcPEjI75wMS5oS69Jke5dU3OnuS7rC5yn2zW6gWndKOYe/ZId51AofXAPsRIdHi
	Cppskcr4Cb28FW4YrKZhM9MjLg0k1qYTuEK8ZcGfWL4OktpqijO9DODSeU3H8V5j
	NOmhbkD5eXkWaYupfzijsKOsw1yaOSbXMpKMPbqNFXs0h1gBMOpk/f+aS/q03aWk
	XXgCWL8n6A==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh94y4pf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 09:39:40 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62D53K3a014698;
	Fri, 13 Mar 2026 09:39:39 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cuha8e2sp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 09:39:39 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62D9dc0U57606626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Mar 2026 09:39:38 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 89BD558050;
	Fri, 13 Mar 2026 09:39:38 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C7AEC58054;
	Fri, 13 Mar 2026 09:39:37 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Mar 2026 09:39:37 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 13 Mar 2026 10:39:37 +0100
From: Harald Freudenberger <freude@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: lirongqing <lirongqing@baidu.com>, Holger Dengler
 <dengler@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander
 Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/pkey: Remove synchronize_rcu from
 pkey_handler_register
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20260313090641.13729Aae-hca@linux.ibm.com>
References: <20260313052312.2389-1-lirongqing@baidu.com>
 <058c161c4e82d2d78ddb9c52cfc8ee50@linux.ibm.com>
 <20260313090641.13729Aae-hca@linux.ibm.com>
Message-ID: <f6780bc18814d25c2487e51ef64dcc08@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QKtlhwLL c=1 sm=1 tr=0 ts=69b3db5c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=zuLzuavZAAAA:8
 a=VnNF1IyMAAAA:8 a=69zs-H1v8mSJLVq8d6sA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA2OSBTYWx0ZWRfX59y93FRDLBj3
 3DN50aOsEwnBhdNY/iRu+kZr8cRv4oFB4jRlnRItwhIk5ujfPB6VJ4izq6S371Wir+aac3cazbj
 s/pp5iP28Wz201hDaa24dIhsuwVjTEl2mSc+8OI1sD4JeJaCDQaLsBo3K8BKlCiVNz8chyI1nHr
 IE7WdyR4PpnjI1bPK1s+aUdZ5LYHpYm2JP0CBxQ7Ydc8tMvwk/i+2OkU3GVZRWFEuBV5CZgfhI0
 9ll/gEmUqB8I8xhiJGudy4Ke6DKLUHamqG2LMZftfwBM8dJiGF93pkcRVAF/Bt0NjEkYAV7T7/i
 qktyAqaWSSXuH3PPkxiJ+CQMCVPPCmO/TDPpD0UTr1eLT8e7ol4/mwM3gmYKZa5Ln15mCm9wYZN
 oI21WOMvyP1o9aLvif24WSNUFRvtQBRQg7iVVc1pW9yXJ8DzkfLIrEW3B3l/abTfdLwm1f/NOTw
 9uohjhZlcUgCUpjAwzg==
X-Proofpoint-ORIG-GUID: swXUrimCMpKN8rMB4hmnPMvq53pyY4Te
X-Proofpoint-GUID: swXUrimCMpKN8rMB4hmnPMvq53pyY4Te
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_01,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603130069

On 2026-03-13 10:06, Heiko Carstens wrote:
> On Fri, Mar 13, 2026 at 09:32:39AM +0100, Harald Freudenberger wrote:
>> On 2026-03-13 06:23, lirongqing wrote:
>> > From: Li RongQing <lirongqing@baidu.com>
>> >
>> > The synchronize_rcu() call after adding a handler to the handler_list
>> > is redundant because RCU readers will either see the old list or the
>> > new list. Removing this synchronization point reduces the blocking
>> > time during handler registration.
>> >
>> > Signed-off-by: Li RongQing <lirongqing@baidu.com>
>> > ---
>> >  drivers/s390/crypto/pkey_base.c | 1 -
>> >  1 file changed, 1 deletion(-)
>> >
>> > diff --git a/drivers/s390/crypto/pkey_base.c
>> > b/drivers/s390/crypto/pkey_base.c
>> > index d60cd98..c2e29d6 100644
>> > --- a/drivers/s390/crypto/pkey_base.c
>> > +++ b/drivers/s390/crypto/pkey_base.c
>> > @@ -60,7 +60,6 @@ int pkey_handler_register(struct pkey_handler
>> > *handler)
>> >
>> >  	list_add_rcu(&handler->list, &handler_list);
>> >  	spin_unlock(&handler_list_write_lock);
>> > -	synchronize_rcu();
>> >
>> >  	module_put(handler->module);
>> 
>> Thanks Li RongQing
>> 
>> Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
> 
> With synchronize_rcu() you do know that other CPUs will see the new
> list after this function returned, without not. Is that ok?

No - If this has side effects then I'll discuss this with you and
then may also run some tests - so please hold back until I'll give
a green light on this. Thanks for this hint.
