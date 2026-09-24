Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8794A4845;
	Thu, 24 Sep 2026 15:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790264097; cv=none; b=j/nCiipZ7IVS8V4YxfbK0M9QnE1Npkmg95COUivtpuJhUuFTkm0gsbpbc8gblP/TJhCGt3/OLIpxRVyMW6LWy62McQ2GOC3lpoyz7KmiHG3z4lys07zhTxVZNtVGvX4qtcYJHvvaexjt/fObdvBl/ahvJc+YoqGmKgzi1Sz9Hs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790264097; c=relaxed/simple;
	bh=N2lMsQN+Q9B3c/mexXo/EjWoXwkG5tKsC1BO8LC9Gak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YGTqOJRtTNOkJAvkAbSRPl+7iCRLVntHklziCLmx4AeQws6+eCJguoAowbmGq4mOSiAGENCtb7dRccgTdLK/XwaU6kUkVGlRI+nw79755CANTfD0hCy3eM2dByNcm3zTRkzrlViyMuw86ftFcCoW45VuE+O+CeW2Ovxvd1mZ2BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rebIgi4Q; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rebIgi4Q"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OC6OH72028482;
	Thu, 24 Sep 2026 15:34:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:sender:subject:to; s=pp1; bh=Hhcn1wqW+PXZeuaGIXenud0
	1JesMRLgOsjsw1J/Yf34=; b=rebIgi4Qi+hedacVno3SgnY6O4TFQ7HqW22MNwr
	C/hfOQqbh6nuK6vPpc16Cgu6z8z3xlrwQoJEML0xWuahnF5w+NbADb36ewtvHfoR
	osRAPZqpJ+foh8xjz8l6No5EXjaLfTM4oFYDKMSRSZbTeux6OPDUI0U0Reftz7rQ
	uNyjLsA9rWqMN3pNgXTo+y+gnGg9fdnBVevvR3cXYZ7oGycqYFq9csdgvS8DtHNU
	hKtJxONHdnFaxlRGK+zfx2W5V9LFCuP9M6S34cedmCT4viFGB44KEjUqq9bKP86S
	9SNUCcH4dm76dU+Nnj75vJxGnhgF9mqkRaY3FBqnbW1gkHQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1sbeq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 15:34:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68OENonc905538;
	Thu, 24 Sep 2026 15:34:52 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvu7eap6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 15:34:52 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68OFYnSD43450794
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 15:34:49 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3EA322004D;
	Thu, 24 Sep 2026 15:34:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DF7620043;
	Thu, 24 Sep 2026 15:34:49 +0000 (GMT)
Received: from vela (unknown [9.224.91.188])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 24 Sep 2026 15:34:49 +0000 (GMT)
Received: from brueckner by vela with local (Exim 4.99.5)
	(envelope-from <brueckner@linux.ibm.com>)
	id 1x9lTE-00000009JWw-40H9;
	Thu, 24 Sep 2026 17:34:48 +0200
Date: Thu, 24 Sep 2026 17:34:48 +0200
From: Hendrik Brueckner <brueckner@linux.ibm.com>
To: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
Cc: oberpar@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        brueckner@linux.ibm.com, mjrosato@linux.ibm.com, farman@linux.ibm.com,
        maximilian.immanuel.brandtner@protonmail.com
Subject: Re: [PATCH v3 2/2] s390/sclp: Implement resize for sclp-vt220 console
Message-ID: <arVDGCASlgATCE67@linux.ibm.com>
References: <20260924104732.1978942-1-maxbr@linux.ibm.com>
 <20260924104732.1978942-3-maxbr@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924104732.1978942-3-maxbr@linux.ibm.com>
Sender: Hendrik Brueckner <brueckner@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: vRdlQni7PfDZId8IyKup-VqrvUlaJvnN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2MiBTYWx0ZWRfX1UWHrQYB4HOw
 W6ifyGxEp+T6jvpnM7OGAxhD49I9u+JuCyKHVniGMoN9NGUzzim7MSauHkayzTsGfCFAHriJ6d2
 yQmsau24Wf3I1EKz1Lw0cBbz0uqugpXifBzS8h1VV6JzWVP4XWxmeQ1TMjMqiKKldwu6b8HFGrN
 V1vs/BTrw9qYgP/KmBn4+WcHctUWRVsApnXOnzWBGJZuMiqOeF7IE7lbyJK6oPcsCwefFQpitfM
 6z+Jb43jdQ95hVnWM/IytpQs4pFONwUestmVHJbomlhN1gVGTbc6/mv1zvGo77uzxC5MpVzUFVZ
 vU2Fshcz/tMxvkdHL1cbBOF7Ln2TbXbdo1P/YJkzHBs2YgalRxc+6k2b2HmFxHZ2PKpI+JdL7QN
 5PLp95zIbokuMUcW4GznOnejHLxYBJgjD0S+DHFjk0DQTtpEUk15I0H/t/yM6UcbjdrEjVQJcKp
 uCSSsFvzShvRirQSfWA==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab5431e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=zBLIaIyO4mf18BS1cK4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2MiBTYWx0ZWRfXwmPa0VIIGUOq
 K+P3K3b/OcJkJksZleoBCN1NICDHQGTACtMfbS9VOy4olMwUUDx/VDc/+I1sm6TIRYk4L2W4sJQ
 qhwpUH2vamjQU6t8wv+Kis1L9RY0FqA=
X-Proofpoint-GUID: BLb1vemlKXc6X5gBwQdvZXYirNYn4Wwo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240062

On Thu, Sep 24, 2026 at 12:47:32PM +0200, Maximilian Immanuel Brandtner wrote:
> Add support for sclp vt220 resize events to enable host-initiated
> terminal resizing when using the sclp-vt220 console.
> 
> This allows QEMU to dynamically resize the console. On older kernel
> versions, these events are safely ignored as the kernel drops events
> with undefined tty codes.
> 
> Signed-off-by: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>

Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
