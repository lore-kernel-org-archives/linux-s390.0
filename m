Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE6F13B792;
	Mon, 26 Aug 2024 08:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724660566; cv=none; b=XlX+k44D6pDKOkBrzKoNRsGGjI+FDvGlF3sWdXbcxjAj9mdoCI4Q0pKPmlxOHOldX5N+3Ng6wot7kx+mavajDDdFKIEDKpY2jlkESk2grD9TXdXyLR3iEIXxOfx+bjzZWao/yVEqxBJ6xJvvt5uIwU4J2wbxe1ZHYKWv7h1SAOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724660566; c=relaxed/simple;
	bh=GTioHhyTFfM2CxlWtvPjVN4dSZKtrlzENP2NT8kYuAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFnmpJvxzOWfPTh9u8gfouNvLD8tBa24/nlzGSUSaof8CnVTL3yG0XGsewiuA7CC0pQxPPNaesXLe339ehU9OWwluFqqXg32seydPQi1fEgvDq5h70WaVaL2/OuJ9k+0FhffylkIecW4ZmOGMFxDkKwGHvI+39U+rFTNEBLrS4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZkOhw5hn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZkOhw5hn"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47PMYvi6030119;
	Mon, 26 Aug 2024 08:22:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=GTioHhyTFfM2CxlWtvPjVN4dSZK
	trlzENP2NT8kYuAY=; b=ZkOhw5hnFMuQzwAxSxMnG84Qbhwu2HEtHbq4GY74/vv
	AaKnbHAplGJ5FdVq/wWsM9+mpVRN9huIW5jUfX3K7WBvafZC3UDHXcTbOqU1Cyp5
	PJUiertQouJ34RF8gsdgdEfmxgCHrsLlYQVF9+3hzIE/bTFwWfVtoabcS1od+KIi
	7byvicFFJzC+0XVBdkPeP8O1tJI/M6LLlPX0JwomoEZsbl+n7eyNZ1/3MjSsplw8
	X3z9pV8CxEElhD6y1gCpOXNdzaHVqeDOHhJd8tRsdXX6LD8HavDw8yD/ryyNBml3
	bZWq+tp/Mf8/PXrLsQZTVkOv5wD0OQZzXNPnm2sz2Kg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 417gr35t36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Aug 2024 08:22:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47Q4jfEC027998;
	Mon, 26 Aug 2024 08:22:35 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 417ubmw2ky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Aug 2024 08:22:35 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47Q8MVHk26936044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Aug 2024 08:22:34 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D4B1420049;
	Mon, 26 Aug 2024 08:22:31 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7937120040;
	Mon, 26 Aug 2024 08:22:31 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.84.118])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 26 Aug 2024 08:22:31 +0000 (GMT)
Date: Mon, 26 Aug 2024 10:22:29 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Omar Sandoval <osandov@osandov.com>
Cc: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>,
        linux-s390@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>,
        linux-debuggers@vger.kernel.org
Subject: Re: Incorrect vmcoreinfo KERNELOFFSET after "s390/boot: Rework
 deployment of the kernel image"
Message-ID: <Zsw7RU6gYHFkw9YI@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <ZnS8dycxhtXBZVky@telecaster.dhcp.thefacebook.com>
 <Zn1uTZdlYNaRFUqK@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <20240709212141.31160508@meshulam.tesarici.cz>
 <Zo5L9xZtIs4dCf0E@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <ZpBrDvUpn4SzaqND@telecaster>
 <ZpEyucQA1rctAts6@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <ZpE7AsR-nD2tNuTn@telecaster>
 <ZpT0loUJ4KdabiCF@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpT0loUJ4KdabiCF@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Qv3syx9gwuLa4h-UlJnLPjpsTPcBusD_
X-Proofpoint-ORIG-GUID: Qv3syx9gwuLa4h-UlJnLPjpsTPcBusD_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-26_05,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 bulkscore=0 mlxscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=576 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408260064

> On Fri, Jul 12, 2024 at 07:17:38AM -0700, Omar Sandoval wrote:
Hi Omar,
..
> We have different approaches in how to get it done, which are
> being investigated.

Could you please check whether the recent kernel solves the issue.

Thanks!
