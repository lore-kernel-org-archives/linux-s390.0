Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9061B1E00B4;
	Fri,  3 Jan 2025 14:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735914109; cv=none; b=uVdJZiF4tg6HHDAwC3W2eNYaWaZDpTN2nusjCbKWm7WnUYhqReB2WIBgc1yLivqaSNj7zrMcP3o4rlKXxWI0qhBHlNga7hBhnKbJY6ZePjGGiBa8u895qr0gZHGVnk1XzIQkTz6FR8P1tH28zTBagC3wjXGH05vtQRcI7DfgI6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735914109; c=relaxed/simple;
	bh=jcSgw8butP4GlvlrqNp1QDvd/uvJ3UtBM81BnT2eRAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WnWxsx7IRqPrE1dlemp42C37AotOuXi+UJvAmZKLUj/L8h9GhtMNNQvZY9DHoMNS81lrxF/dTxIewmy3YbJbQDOGKjajQ8H0rYak7FdVChmLamS/t95I4W2IejhEptV+ZfP8GUtXhUVrhqp9qpcHN3V6TMu3mslESQFJIXW/mp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eeRfhvFf; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eeRfhvFf"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 503E6j0L002130;
	Fri, 3 Jan 2025 14:21:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=S2aJxR
	sv5pZ/I4jhZBuTuQRq2xwcQMg4ciSfQjSnoGQ=; b=eeRfhvFf4dqsg2o1pd5BYy
	EOX0Ic91gwytM4VfZxiH7UyXskuEedE+F2fSNtz+DS/33LeG/foxQxkYWftp73kB
	nWOB4Ui0M1kwQgDOCRZUel1HmZgnFOxyVEODWw+7jAvzpcjnCHhbgSxkMKMI7SPg
	5zcOgJkkKJbq/KN7TttU+lR9cSfqAs1BYNENpUfepWtzf1UKNqZ1zZiwufg1UuMg
	RnVKkCpSFAPA5El7i0/IaaoWtWllmZiiEtI1/e9uSYhpkta41rMxcDjcIQugO4he
	IBRSkA38/jzFnMaBxjIxcHh5g3fWCGtthDjN0O1N6Z73A2RJ48Tys1+/jVWpw9Wg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43xhc501hu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jan 2025 14:21:46 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 503B1oTk014587;
	Fri, 3 Jan 2025 14:21:45 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43tv1yen94-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jan 2025 14:21:45 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 503ELfGd38732276
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Jan 2025 14:21:41 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EB352004B;
	Fri,  3 Jan 2025 14:21:41 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B78FD2004E;
	Fri,  3 Jan 2025 14:21:40 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.179.15.34])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  3 Jan 2025 14:21:40 +0000 (GMT)
Date: Fri, 3 Jan 2025 15:21:39 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Holger Dengler <dengler@linux.ibm.com>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] s390/pkey: Constify 'struct bin_attribute'
Message-ID: <Z3fyc73WKFXOYFNi@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20241211-sysfs-const-bin_attr-s390-v1-0-be01f66bfcf7@weissschuh.net>
 <20241211-sysfs-const-bin_attr-s390-v1-5-be01f66bfcf7@weissschuh.net>
 <2295c2a4-7d7f-4932-99df-fa9d4b6186ae@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2295c2a4-7d7f-4932-99df-fa9d4b6186ae@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9esif29Ypt52DvWgje47bh1PoANbniv2
X-Proofpoint-ORIG-GUID: 9esif29Ypt52DvWgje47bh1PoANbniv2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 spamscore=0 clxscore=1015
 mlxlogscore=545 malwarescore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501030124

On Thu, Dec 12, 2024 at 04:03:18PM +0100, Holger Dengler wrote:
> On 11/12/2024 18:54, Thomas Weiﬂschuh wrote:
> > The sysfs core now allows instances of 'struct bin_attribute' to be
> > moved into read-only memory. Make use of that to protect them against
> > accidental or malicious modifications.
> > 
> > Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> 
> Thanks for your contribution.
> 
> Tested-by: Holger Dengler <dengler@linux.ibm.com>
> Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

Hi Harald,

Would you like to pull this patch via the crypto or s390 tree?

Thanks!
