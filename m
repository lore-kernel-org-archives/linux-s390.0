Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2AE17745
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 13:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781877469; cv=none; b=H7GVySIqYkbHtfA4cZq7LGhRQrjk5S7DSlVNVZjCCfbtJlJI6FpDwJHi5e06MuR6DROj9VykU/MfmgYRa0bURUi1koRr9NgwLQFvXtZrAQ70w4pAcgprJZCapZf9b1ON450eEPKN5jhkuKshOWAZgcGKAMCxKokVami8kLCxirA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781877469; c=relaxed/simple;
	bh=73sEqT/hDY4BleJLLM6JJwHwar5B80Hn0zCBkmLW5go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1Jg4zBwtKn8sYklslKkv4SPebVfvJBFqaWda3Euc7cGi0Gf0D3OAGis1a9u+oKPrDWA9kJ094cGllfIaql1eHqguj7JbNJU1uvnGazjLQz+DTDvz/0+n6iJ7stmK930CLTEtricXutTwWu5WIYoCH31JU7tLxEtuvZ+ZfhFJNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MJPm3X30; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MJPm3X30"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65JDIbJi2321176
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 13:57:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=XbLhiHski/5gKUzcPshlSMs2VXPZDS
	CMJ/7dhQobU58=; b=MJPm3X30Z3JCB5ocIIrRe7vsAW1RuXshi2YTBwznvEU+Nq
	YRocBrc4pRlZtjxQDV9iE/ow5QpmxtlL4igMTt+sNr2BoGxSxxYMSb7lI1paNTYY
	DgVuSQNnAe0kMNS1ja5PuzD1kTLisxjvrTROrQ8yRPvutQTwemY0KyxPfC31P6Gc
	JL10fvBM5gL/IJ/b11HFZ3r6mJZG4fmi26lqWm+GHjDI/0f/AqvLJ+gI1GDGTTcR
	91voX29028qPdfqbepJ5h2hziZUyolKTeF73mj8ti8avzMitABEHWfaQwJQxsx5x
	kivlYWWo4EDl1IZaQxcfWkq3CGXXXrjxmWLu2nVg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqxnp72-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 13:57:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65JDnbMo020658
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 13:57:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172h3st-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 13:57:40 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65JDvbWR45482468
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 13:57:37 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 192762004B;
	Fri, 19 Jun 2026 13:57:37 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0EC720040;
	Fri, 19 Jun 2026 13:57:36 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.224.92.206])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 19 Jun 2026 13:57:36 +0000 (GMT)
Date: Fri, 19 Jun 2026 15:57:35 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2] s390/traps: Add exception statistics
Message-ID: <bafaf879-74b9-4f64-82aa-2cc1ad7dd9d8-agordeev@linux.ibm.com>
References: <20260617123350.3220729-1-hca@linux.ibm.com>
 <36ffea91-aacc-4687-8a25-7c4ebe7c9b74@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36ffea91-aacc-4687-8a25-7c4ebe7c9b74@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=OcSoyBTY c=1 sm=1 tr=0 ts=6a354ad5 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=0lWeeNi243URCxY7aJ8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDEzMCBTYWx0ZWRfX3cNsTD2lgudo
 akwFeyyf/eO5MyOeRrM+uSODN87z6bRUYAGfM6454CTwlc++BHHY/64JS3B1k3CMw6M5DF3sJew
 1ruGHIEaVN03Eplf80hBB+pP74U6XlbuZHDisqMkC4H4jlB+TkrDGM8PWCF8XLuTQ1nWmSnJWiw
 yi1V+izL7YNy0+jkZMoS2aTlgb8kNmI4sTR8dJwA9oBpZ32ZvQ37ien4VwqOIOV0bzTVv3AJ7Uo
 nrpKY+sA6MW1LMYzOK7knQNWfZwQo8xMJPPwF7RCLc82qsS2ACLH6BeuykWxi5pFHCsuVfSKbLr
 VfWObXcp4f+sap4sKeIaM9DX149Ye1E4pJBoo44t88pyAuiPKfhVqvmHwswSec9DiLgm4eXwyp7
 yKqBY8WSDtNvJT2NEaEDlo6aYAStQ7nzq3awbYK4fSL1ekA6xCHNa/eyDbnFEa2ZJmiI/CIYD1i
 jazxA79QrLPx0N1HyLg==
X-Proofpoint-GUID: XBEnnOQR55M-y-uS0zT-cTbRNL7VU7lS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDEzMCBTYWx0ZWRfXwknhYh8M3dDq
 YA7roYjmlL3+EJALwrOdZpDKNY5SPiYb25qfVLZj6wSKu5H179Ny9G1JLc1hlaV9l2oJZ7s8YmO
 3oHjQ6deVdDrDK7ARGvxRErC2JZwrrA=
X-Proofpoint-ORIG-GUID: XBEnnOQR55M-y-uS0zT-cTbRNL7VU7lS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_03,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190130

On Wed, Jun 17, 2026 at 04:37:56PM +0200, Christian Borntraeger wrote:
> Am 17.06.26 um 14:33 schrieb Heiko Carstens:
...
> > Suggested-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> > Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> > Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> 
> Looks good to me

Does it also translate to Acked-by or Reviewed-by?

> Tested-by: Christian Borntraeger <borntraeger@linux.ibm.com>

Thanks!
