Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D6813792B;
	Thu, 27 Jun 2024 09:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719478985; cv=none; b=mQFhVXNCd7oBK0BcYSn4687q0DXaFBfKOZDZ8W/HhvxXnkh0CNNxm4cdOpUzhOGIjRYN5qsMhUMpc8IRQuvVBLkutXBbT1Bv9cq+tpagpKtFUxuKA1138iUBElQSedx3rLi2DA9TRfvKsmWHp2WKSeYuga7WwMS+0yPbhFqRMPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719478985; c=relaxed/simple;
	bh=FGyGAiTX6P56owmEvNEH+0PwQ9q/+0VQUBlp8LA9Vv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnTU/minqB24Sns8JdfftNYPw+LqmlsEWCdXaHVdWrXQSiaKYg0TFImHdSjX2era1COT+NA1wVY/xTN1uHuixD4jXnmjc8/uCcxiRSvK+ew8KMKOOEQPER+2Vsl/mST/IJuWo3U/nq/KCV7p7u3Sg6U4AeawlOKCNwRDhFulUXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gGLn+ZYo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gGLn+ZYo"
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45R8StkQ007467;
	Thu, 27 Jun 2024 09:03:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=FGyGAiTX6P56owmEvNEH+0PwQ9q
	/+0VQUBlp8LA9Vv8=; b=gGLn+ZYoeoYgGn1ktWELaQfhYo0giNJZrB4s/SbF+fJ
	NnlODGj+v2SYbTERxNau40mGaQk01F1fE9h0qpULr9nYsZCkC7484ERBoCcyL4u+
	2dOlOWhdu1zkz9DZCPCesPB8Buy76890Aweu4CA7ZKSmg2eaoWLn9ouTmRNczwww
	Wcehpy/XV9xnaNRkvjqp0lyX/atVIwkF2Z02fsQRZ2GWUqQ6Omlv13uiLSjpy72G
	BkQCvrR+oaOYCUA+sfdU9ibnyTe19GtHLWNxEOtXoRW4QT1vBfFFjdA9WeCIIoFr
	RMWFNPN5uop1z3/MAh4mK2kB1OJpnjAgD5RB/RVPqyQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4014km82sj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 09:02:59 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45R5xIKl000411;
	Thu, 27 Jun 2024 09:02:59 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yxbn3hfku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 09:02:58 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45R92rLW33030432
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 09:02:55 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 730572004B;
	Thu, 27 Jun 2024 09:02:53 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A8D220040;
	Thu, 27 Jun 2024 09:02:52 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.32.48])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 27 Jun 2024 09:02:52 +0000 (GMT)
Date: Thu, 27 Jun 2024 11:02:51 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] s390/lcs: add missing MODULE_DESCRIPTION() macro
Message-ID: <Zn0qu7f2uysUGWTF@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20240625-md-s390-drivers-s390-net-v2-1-5a8a2b2f2ae3@quicinc.com>
 <cd626321-51e1-4e69-b043-a838d1351de7@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd626321-51e1-4e69-b043-a838d1351de7@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: teO4MY-9JC5AoN7yuZtYwjGwWK2TxZpp
X-Proofpoint-ORIG-GUID: teO4MY-9JC5AoN7yuZtYwjGwWK2TxZpp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_05,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 phishscore=0 mlxscore=0 adultscore=0
 mlxlogscore=776 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406270067

On Wed, Jun 26, 2024 at 01:50:21PM +0200, Alexandra Winter wrote:
> Acked-by: Alexandra Winter <wintera@linux.ibm.com>

Hi Alexandra,

I guess, this update go via s390 tree together with all other
MODULE_DESCRIPTION ones. It is up to you.

Thanks!
