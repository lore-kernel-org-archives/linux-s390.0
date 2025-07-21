Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD77285C87;
	Mon, 21 Jul 2025 10:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753094170; cv=none; b=L9zCKMMz8cEhQhyEqzneywyrenoVxrxWu649JXkANrw+/UvN4wd79vgnL2D4koRR+5xliwuO4qpWjsmLiFMfzprHcr+/UYf4GCAxocV2ArJQV+G5PWsAOD3a+mmBgFOuqmeqYjOBuyVXmpp7sXyk0tQxQkiubqPHIkYadTPaG9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753094170; c=relaxed/simple;
	bh=F4DWEShYlgi+O2vngYEWDDPz+7ETvlg5Z1pg7zYX228=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oeZ1AOqyaBMBolEBbcXfIudYL5JKUH9VgcWwtq0puQUBu3kPWd3WESs1x00pj+u3ieJ3Hn1rua/FQauO+nFL7UCb0Ev/KaRPbY4ztYO9lnXtsFjSsdBc0hRlmImqaBvdmo0l2E2/QurrLvyHHSjHtqaenDmz8JmL37oIORlgvBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hz/ejtxO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hz/ejtxO"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56KMcqpT000727;
	Mon, 21 Jul 2025 10:36:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WV4O+A
	BuIlGQ3hQz6gkTQy3zpggdnbsZnocNbHSe898=; b=hz/ejtxOTHs5/gGtvBNXzO
	cg7TVmcRs6NpmvWWXCvkSBl5aZKyRhFn5ORbMWQwKze5NjVPRQUB0TUfK4eUS2zl
	8qJA1buh6qqhXXcHdvsxg3TLQDQcbNa8jg3rzkGZdM/bdIUxDz8OuACOXLgxkTPm
	AIbO+tT5klFPNjk/+Z2LOFjx0oKOyMKRtglj96LGqnxmbJqt0Uz7IoVIVvgAxKYk
	l+WoB7uZqGNFKkS8D6IMZxa8xA5P34m9K76dxNovT/CQ1xZzVkWqjSG1dGhIrTkp
	Tp6pNbtFWvxhJUDL1yawnw7qLXG1LoauwsewE8fOwFj41mfVhyQOVzJFfiehjVEA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4805hfr0kn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 10:36:00 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56LAU8bW028724;
	Mon, 21 Jul 2025 10:36:00 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4805hfr0kh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 10:35:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56L8knCe004732;
	Mon, 21 Jul 2025 10:35:59 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 480u8fmt18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 10:35:59 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56LAZpM350069864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Jul 2025 10:35:51 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E5152004D;
	Mon, 21 Jul 2025 10:35:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 95D5420040;
	Mon, 21 Jul 2025 10:35:50 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.111.43.101])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon, 21 Jul 2025 10:35:50 +0000 (GMT)
Date: Mon, 21 Jul 2025 12:35:48 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Andrew Lunn
 <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian
 Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle
 <svens@linux.ibm.com>,
        Sebastian Ott <sebott@linux.ibm.com>,
        Ursula Braun
 <ubraun@linux.ibm.com>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aliaksei Makarau <Aliaksei.Makarau@ibm.com>,
        Mahanta Jambigi <mjambigi@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 1/1] s390/ism: fix concurrency management in ism_cmd()
Message-ID: <20250721123548.31401ac2.pasic@linux.ibm.com>
In-Reply-To: <af7298f5-08a0-4492-834d-a348144c909e@linux.ibm.com>
References: <20250720211110.1962169-1-pasic@linux.ibm.com>
	<6b09d374-528a-4a6d-a6c6-2be840e8a52b-agordeev@linux.ibm.com>
	<af7298f5-08a0-4492-834d-a348144c909e@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDA4OSBTYWx0ZWRfX6FeVIKVayOkS
 S/WcbnzdSs9yCZNdP9qIugIlJoaSQXou+BDhVAuD/W2kNp3cYthyLyz5CkhTEMW0vHmsuIpbdQZ
 PQYpPizpY1F0OQP4zW63RfKdQkaBNiGnCVSZrzY68nCq9925R61z6BjUYpIBFm/1HbfUHDaa41M
 EEq4jPs1pGLTtYiXtwuPMBboXF0hRPJ0tnFrQ/5BT5iU14ZIwuWV3qzTVrJuCVM97N2OkmzmUE8
 RbL+4WiL/LiEGy6rOMgC9NNtHEqYbHP/L4u1LZtyFUHx/3CFwptZCsHaq52wp31V8NuIUwFOwuu
 ZB2fLJFcjK2SRoqiN+cz63KYZm8p4fgyb8QM2wDSiDzckWO1HQ6JAOsvCsGsHVqNypey79/lneS
 w9CEOQ3guSNy4BJR6tU/TQkiEXAI519mHL92wCRM9zRJmL69W9PrdTf8Ydo6zUve2Y/sqa7C
X-Proofpoint-GUID: NEZNiAB_40OMK-ZM02ykhqsmLTEvM3KM
X-Proofpoint-ORIG-GUID: l1MHd4f7ZxURLXhPrHMGUxm4ilWZHldc
X-Authority-Analysis: v=2.4 cv=X9RSKHTe c=1 sm=1 tr=0 ts=687e1810 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=pGFWBfxQ5TguR4G5NxIA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_03,2025-07-21_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 clxscore=1015 mlxscore=0 spamscore=0
 suspectscore=0 mlxlogscore=585 bulkscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507210089

On Mon, 21 Jul 2025 10:17:30 +0200
Alexandra Winter <wintera@linux.ibm.com> wrote:

> >> +	spin_lock_irqsave(&ism->cmd_lock, flags);  
> > 
> > I only found smcd_handle_irq() scheduling a tasklet, but no commands issued.
> > Do we really need disable interrupts?  
> 
> You are right in current code, the interrupt and event handlers of ism and smcd
> never issue a control command that calls ism_cmd().
> OTOH, future ism clients could do that.
> The control commands are not part of the data path, but of connection establish.
> So I don't really expect a performance impact.
> I have it on my ToDo list, to change this to threaded interrupts in the future.
> So no strong opinion on my side.
> Simple spin_lock is fine with me.

I agree!

My train of thought was, lets go with the safe option and look if the
maintainers want something different. I didn't feel confident about
trying to understand the details including the contract between the
clients and the driver.

I will change to simple spin_lock() at the end of the day if nobody
objects since the sentiment seems to be going into this direction and
spin a v2 no later than on Wed.

Thanks for having a look!

Regards,
Halil
