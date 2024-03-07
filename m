Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6878A839FB;
	Thu,  7 Mar 2024 09:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709804293; cv=none; b=gdVTeXxyZuDw5rnbsCx4tVSTTFwjbrufAwe3QESgpqV9irFs9xmqjxbliGtRnXDAk00hP6MpqiEJLd83xhbl9CuywjJOeY4dgD6BuUnO18WafBjEDIgI95KUzppqz7QxBdYm9IFPF0cDaRchbIdKx4psUwtBmqFaSkXyfltAzmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709804293; c=relaxed/simple;
	bh=DibnNY796LQYxeRFpjwvSuqIkZLq9V4WTOvt1QT/C+Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=O9vIih7UDdNtngwB3c0z1rK6HCHJ7Cw3UBxmvX9noUOb6ZCy1XKIkTxCkTin15yU2wkeCr5OKrLUmT94glLGDyRKscaVxRIFxcPPzMBTh8L+5bgiED1oI+dAVSz8UIDWdnf6p4Zqhkxvb0NnEXPL5cu5z/8yYwDkACNO4OLwh7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QqVJDRYo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QqVJDRYo"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4279RCYN015474;
	Thu, 7 Mar 2024 09:38:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ODgVjKqkBlf6CS46T2yRBBTXmDr+cpiPqwVnyv0RLCk=;
 b=QqVJDRYoTIzQaxELsHjuErfrBtfMUJKtNo+eGKOTZxYyIe4z4enem3dqP9K9nAoZ/6UB
 rTg0K9ee+vEawy5CXwL7coxByQooRl3rE4+OM/+kBvr8r1uuNuCGz7Fz7g6H7ZzOWuTF
 2fXhxi7oz+4YmPlYT94mvYTVi+xRo94wMNz2OrbJzLkPjta27LXrBmnif0iBVeEp4MmF
 RAWmU4ltqbMLkUqFJ1aspDnoTmTaa/Zdu6K6YpU+ODWY0nfGpAjpr3Tkhw+z3snCpq/t
 XwbGgKd9m0ZjZoi/owaZ76lcm/W1E9AheHcjofxw3hDGH9SjK50rgNkGJz66vIM1UPK6 dg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wqay9r8gw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 09:38:09 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4279SQlV022070;
	Thu, 7 Mar 2024 09:38:09 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wqay9r8gc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 09:38:09 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4276h8DU010881;
	Thu, 7 Mar 2024 09:38:08 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmh52m7tb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 09:38:07 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4279c2R739125436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Mar 2024 09:38:04 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 741D920043;
	Thu,  7 Mar 2024 09:38:02 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44D722004D;
	Thu,  7 Mar 2024 09:38:02 +0000 (GMT)
Received: from [9.152.224.128] (unknown [9.152.224.128])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 Mar 2024 09:38:02 +0000 (GMT)
Message-ID: <8fe1d752-9cd3-449e-8bf8-e53cd9d6b875@linux.ibm.com>
Date: Thu, 7 Mar 2024 10:38:02 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] s390/qeth: handle deferred cc1
From: Alexandra Winter <wintera@linux.ibm.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>
References: <20240306163420.1005843-1-wintera@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20240306163420.1005843-1-wintera@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qcfZkVAcbyfhfXroV6PWz2l8wlAVp43X
X-Proofpoint-ORIG-GUID: kdIS5WbfK1JXGewlVq5TqLpfIOpdEAzv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_06,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=575
 lowpriorityscore=0 phishscore=0 suspectscore=0 malwarescore=0
 clxscore=1011 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403070069



patch does not apply. I will send a v2. 
I'm very sorry for the noise.
Note to self: DO NOT edit the patchfile last minute!
