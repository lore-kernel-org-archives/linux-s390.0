Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B164D5BD;
	Thu, 27 Jun 2024 09:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719480101; cv=none; b=cuxTQ66JYEmvz9LslLxkHFKcGOwyCiyyUTrhVL6aIJ4vInpSVXPZNd5zcNMxmSzaRsufBuVHYZebOZ/Pow0ZsOc6p0/8rCAzNXLwXCRIgpngDfn/A9lmIJvcTqmmB35jSCLw+ozpX/WItk0bTuktdyAVOrOVC1j9zfYQmqRPVj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719480101; c=relaxed/simple;
	bh=e4BSBwMBe80sVYMeei63Oc2+3XT2V/MQdNKDbH3ZYzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N8gVilhVCq+6WFw/P24XMTFwLs1nooRBTFpmgMsqBnd+z7LWeYVN2ifnQo1A5IBjKmw+UKwu2a6Ef0RcBrQ1TJsCN8ewRvPSK6D/otbqIKBU2euMGdykhhTRP35vVclV/uHt7AoJ7V+7GTmBIVPv+je6MEpFFAggcuzRuYTjduI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jnmOmUPu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jnmOmUPu"
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45R7xDn4006312;
	Thu, 27 Jun 2024 09:21:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=s
	N01qmPbmwaIQxjxlJmpFdbVlb5CUPO354RDYQ3AJg0=; b=jnmOmUPucKjoVXGHh
	UqEyBZ5IJ8pipFmJv7nLv0J/W12pOTu0o7taCEjUOWY9WvGUXpMyq5P/K0W7eWoM
	KXc2S1JYiZaR8pXlteuTTOH6R51kTvOMHSqilCHybI41otYvkkOxuWtvKe1dscfm
	M8k+2S1DsXbq7VXDZ9gZuEvPYkHj+W9eadxVkSZDg2wYgoqKHx47bwFt6ml0HfEK
	aIXN9/oMezEcdSyUO4N9/+OlEdskL1vcvZn9yzPzlnGbPJqYpKFOlVAm/mQB300d
	H7Unl1AY5iL3z5STMWh6xu38gtvVMkBxlxyJwXAQz/FvB1UyFs8Y1VVFy0+9bNZJ
	vCOHg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40145v86yx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 09:21:38 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45R7KAGD018156;
	Thu, 27 Jun 2024 09:21:37 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yx8xuj6jd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 09:21:37 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45R9LV7J44302824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 09:21:33 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E5A92004D;
	Thu, 27 Jun 2024 09:21:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3920920040;
	Thu, 27 Jun 2024 09:21:31 +0000 (GMT)
Received: from [9.152.224.141] (unknown [9.152.224.141])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Jun 2024 09:21:31 +0000 (GMT)
Message-ID: <92a2a06b-817f-4412-ac2b-763c8a727409@linux.ibm.com>
Date: Thu, 27 Jun 2024 11:21:30 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] s390/lcs: add missing MODULE_DESCRIPTION() macro
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20240625-md-s390-drivers-s390-net-v2-1-5a8a2b2f2ae3@quicinc.com>
 <cd626321-51e1-4e69-b043-a838d1351de7@linux.ibm.com>
 <Zn0qu7f2uysUGWTF@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <Zn0qu7f2uysUGWTF@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WXVUIP9qoOyQYdDtYHrbcKb7aMUTnVaC
X-Proofpoint-ORIG-GUID: WXVUIP9qoOyQYdDtYHrbcKb7aMUTnVaC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_05,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxscore=0 adultscore=0 phishscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=913 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406270067



On 27.06.24 11:02, Alexander Gordeev wrote:
> On Wed, Jun 26, 2024 at 01:50:21PM +0200, Alexandra Winter wrote:
>> Acked-by: Alexandra Winter <wintera@linux.ibm.com>
> 
> Hi Alexandra,
> 
> I guess, this update go via s390 tree together with all other
> MODULE_DESCRIPTION ones. It is up to you.
> 
> Thanks!
> 


Actually my assumption was that the netdev maintainers will take it via netdev.
There are no dependencies afaict.

But any way is fine with me.

@Dave, @Jakub, please speak up, if you want Alexander to take it.
