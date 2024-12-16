Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F96D2E628;
	Mon, 16 Dec 2024 09:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734340315; cv=none; b=IJkEz76JFscEjusV/XMXxGHaqFwKQDOEQH/qGn7VdsSIu3ZXn7F+WPmB2YrbVYg7UlHOr1xr48CtU7UL2Otjtymkqg5xRuGEbNa5RxcHZ6BZD3HZTt8mFWy2HHWIa34MAeEAUIfNu0SSImqMr+lhsoX+sVpQclGxZXjC4vRUpOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734340315; c=relaxed/simple;
	bh=jc+ktQpe1snGAisoPsN0qsFlu6le9/TqPnUf04ohDYE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dUt9IhzOQZjIigNx8S/ocQv4xnmrbmJX5rWOSQgRoo7Bc6QJKKAOqE+EFpDZfGos4p+4NkUhdiF5zR6JsD9681uTerZuqgZkJWYVNi3riss94upbyScdGBTlwogcMnKyoJfau/qzZCBJCp6lBrS6k8TyUxRKTXWRi6fgqcM/c3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LgjlQtsF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LgjlQtsF"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG85Um5027009;
	Mon, 16 Dec 2024 09:11:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=jc+ktQpe1snGAisoPsN0qsFlu6le9/TqPnUf04ohDYE=; b=LgjlQtsF
	uCWedpcoooVezw6YEMeSvHgzLqd9LocHH2MRUbSTRMZ7w9QACBO2I3GgqW5I/9il
	gcgr44ZNVF2FsuX6nJF/TcHum9wzmG+STIZfKut3ClrLhGQOlG7mCcw0dkS8kuyq
	vJMLWmWaK2jfbGBuP4w1sO53a+XgEp2Z6M2Ib2Dcem7YfjK34RhwXYVRdlaAqXbK
	NY4zifyNvNP0t5jYAy6QfudDIG1uobDdf2HLVykLm4grP1YhVP1papB7yFZtfrOm
	8XZ7TGxbLJigvyX+UHlCYZsJo3T0REFRfmX0wzevYQfCzcx8Q/qoumuWlr72GjAn
	TVXbk6bAMpcxnA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43jgd289fa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 09:11:51 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BG97mSa025745;
	Mon, 16 Dec 2024 09:11:51 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43jgd289f7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 09:11:51 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG56cqV024044;
	Mon, 16 Dec 2024 09:11:50 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hnuk54c8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 09:11:50 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BG9BmiQ29295160
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 09:11:49 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D4BBF2004D;
	Mon, 16 Dec 2024 09:11:48 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C4AB20040;
	Mon, 16 Dec 2024 09:11:48 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.179.5.32])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 16 Dec 2024 09:11:48 +0000 (GMT)
Date: Mon, 16 Dec 2024 10:11:46 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Dave Penkler <dpenkler@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: GPIB build failures
Message-ID: <Z1/u0u9Nu4aEHA5h@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: n7FPiz6nEczHTxmAXZPgqfP8F6fAcdDe
X-Proofpoint-GUID: swZOic95wKZ-YcZEdGzI69jv_opTL1sv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1011
 mlxlogscore=588 priorityscore=1501 malwarescore=0 impostorscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412160074

Hi Dave,

Drivers in drivers/staging/gpib/ cause multiple build errors (I guess not only)
on s390, when allyesconfig configuration is used. Please, let me know if I am
missing something.

Thanks!
