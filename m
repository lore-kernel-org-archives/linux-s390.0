Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A3322FE11;
	Mon,  8 Sep 2025 11:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757332231; cv=none; b=Cl2Ic9RBFHLrH1yPX1gj2Sg7JBt//XvhOMQqnWbsCfORTxWYqzrzPqovcZ46RY/jFHjcNUrjRVWJ0PqB1LXhcdDLEo1fUnlYj9pSnUaPJi/x+c8Cj0A7t6rxtCh8rpoJ534dNmo8u+53iSFJ9km8/bVB4IQ/P/nkg/zMqxG9jZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757332231; c=relaxed/simple;
	bh=5/yENc2viaLvDE2lhMtg0pleiOb8oKvhPHMaLhy7908=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCDGklTPUNiky00ioCjAtuwKZJmVlvF73ENOPdBkBUjW3pbhW5H/5p0hD5VcTZa5Z4Jtnz12xDbrBOawJ3/VTRWw81H12Eo+AKkskparR3hFC5SCgw7mvgLNb+iA3HN6QdLjBMbZJRgF+NnZYlII2mzjxOwGw0erVadiPBXrsbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JTRvQY8O; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JTRvQY8O"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588AtnuB028539;
	Mon, 8 Sep 2025 11:50:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=OfnADRV2nUgqf8EqQYCRBrtiaYJAsj
	WE1pM2fEu4BM4=; b=JTRvQY8OwnxYpQnBQGhATjxVTw/m4MV3M6zKi0hvKq9LaL
	Nv85fES/HmeTP85NBlsvS4ke0+83cZOr8mN7nzw2Rg7T1iGUXuHT0CkEkudMeSH5
	QlzvOILZPrFhhd4YH5jpW0NkM7KIfRhUByUboyFB/uBRlgMeyKLRc4vsJAjSTTDQ
	+65Wi9WUmLdJp1FbcxfzqlkPzi6H8qr53foGOwOYV+UIGmAmbXUrPdh3OQ1BwdHC
	+E/5bBR/618G+5gCp9g9TfFgwbiKBjU2bc+LeZoG8D4vGsl16yKxG6VsCuguX+XC
	dtsaOQKO0JxLQuixrH1Iq5YQv5U3XiZtMirdaStA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490uke6ehd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 11:50:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 588A2gYX017163;
	Mon, 8 Sep 2025 11:50:08 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4911gm5pw1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 11:50:08 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 588Bo4BT52232494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Sep 2025 11:50:04 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6DAD2004E;
	Mon,  8 Sep 2025 11:50:04 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 47DD32004B;
	Mon,  8 Sep 2025 11:50:04 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  8 Sep 2025 11:50:04 +0000 (GMT)
Date: Mon, 8 Sep 2025 13:50:03 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        "Bill O'Donnell" <bodonnel@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>,
        Joel Granados <joel.granados@kernel.org>, Wei Liu <wei.liu@kernel.org>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/debug: Replace kmalloc() + copy_from_user() with
 memdup_user_nul()
Message-ID: <d228ead4-c37e-4728-b1ec-a2d61ccd1f1e-agordeev@linux.ibm.com>
References: <20250904114031.353365-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904114031.353365-2-thorsten.blum@linux.dev>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDE5NSBTYWx0ZWRfX8B7vS5x4tr35
 BAvjLMf6Lid0MTsDeZzGOhK0MP8WSEX5Oo04u/7TB4dcBEO4nFl4D2JcY0cPE72sC3vyme+0nyT
 tl814/wiDOjFiByAqO0qC0z7yoghcdGGjyWuGn7M/zn6Pcz+A568YLZB06BffUdQx7LzIV9P4G8
 IYIoL6KmWBZ+w3kbQ7VLp6j9QOlXQbPF1XV1qT1sCG0syBsqXxnVTQ939guA29TJriphLw2X+DE
 32EipWwYticvS6Q8wdaKCGrm45vLSsSDATQs3nSUoyQBpKUDobsWSzIEG6s+DlhCkU4InVvh4/E
 EQ30b6b2k3SSOjwI7yaV7YNwjm1lCP9LN0yVm7NbtEHgCQg2dvzLEzzRTNFqpBYnl2gvNb2eiza
 +eM0dLty
X-Proofpoint-ORIG-GUID: qi70NmTvlQcxMJ5ezd9YUDQNKlRVy_UU
X-Proofpoint-GUID: qi70NmTvlQcxMJ5ezd9YUDQNKlRVy_UU
X-Authority-Analysis: v=2.4 cv=StCQ6OO0 c=1 sm=1 tr=0 ts=68bec2f1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=-Q-C6ed9KFolZe3n4DUA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_04,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1011 adultscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060195

On Thu, Sep 04, 2025 at 01:40:29PM +0200, Thorsten Blum wrote:
> Replace kmalloc() followed by copy_from_user() with memdup_user_nul() to
> improve and simplify debug_get_user_string(). Remove the manual
> NUL-termination.
> 
> No functional changes intended.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  arch/s390/kernel/debug.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)

Applied, thanks!
