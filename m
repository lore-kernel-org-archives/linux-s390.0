Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BC033CEB3;
	Tue,  9 Sep 2025 13:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757425964; cv=none; b=CKv8wGDwOj7t2BBBUVv4hccX2qoP8Vo0JyLMZ0iAsLa5H6CXPDg/jbXaygvd6aix3gEoZHxwV7qPHf+PNM1TqgQt+XV8arunT4gpHwJgjoZEMotnLWMAGJGpRuHNvM7nKEpaxB/VAADMOcQ7/g+IPW3q/VbFTL7NUXhMazM5BJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757425964; c=relaxed/simple;
	bh=kkqPnMFSXKC58Mmp+u95ABjAXbkgOnz1Uy3x3OPUuAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQRvtBpYOM9e9iXfJraUX9eNZMuPcplYhikp8wKh0VNWvJUmfyPN7+sId6dmsgNr+h6z1ojB3TW94+hsyjKHexX//Eu4yZajJtTrRU4+LxY3cX/qRmf3AAUpiS9nmq09BMz5KJZIDV4HpvwDQK4Ui0yVf0LgNWmkyEcoirrQSuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sGSBQjPB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sGSBQjPB"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5896fLU0018487;
	Tue, 9 Sep 2025 13:52:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:sender:subject:to; s=pp1;
	 bh=BuPG1fP2BiwN2dlCCYD4OsW/T1NO8BqbuJE09pQ1CcM=; b=sGSBQjPB27Of
	/SDJ5ZWMUkupMnht5upok4DeYiP8FbRmOIEX/C3BbesMgXa+z3MT33CaVsBK2uuM
	GMkp+lEk0Kf7mf8lwunHZ4WRFiBukAZPZEb/rnMkXmDEu4Wt8U7ga/OO1ai8B1nG
	xq338KUGXFT4dkIdFSi8HaxKu+YxAq1ZUgc8bLJYaDpCtT3iHd7bHdsJ7QvmhaB7
	Yw15kqzyZ19tIzGZx+lmd/HQ7PSGfuCm5OxOALvn5YD1OF0XZzG9MOmfmB0KB9Ns
	+pPw5/lt6VxtBt7fuqRAhmBJhk+QDWDjMGMB3lgOTUMKugPeiV2ppFPSIfbptWDp
	xHXzEegnhw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490ukedbd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 13:52:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 589B0CSw017188;
	Tue, 9 Sep 2025 13:52:34 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4911gmb7j5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 13:52:34 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 589DqU5257606626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Sep 2025 13:52:30 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DD452004B;
	Tue,  9 Sep 2025 13:52:30 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B4B320043;
	Tue,  9 Sep 2025 13:52:30 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.152.212.197])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  9 Sep 2025 13:52:30 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.98.2)
	(envelope-from <bblock@linux.ibm.com>)
	id 1uvylq-00000000VY0-1Awe;
	Tue, 09 Sep 2025 15:52:30 +0200
Date: Tue, 9 Sep 2025 15:52:30 +0200
From: Benjamin Block <bblock@linux.ibm.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
Subject: Re: [PATCH] iommu/s390: Make attach succeed when the device was
 surprise removed
Message-ID: <20250909135230.GA16134@p1gen4-pw042f0m.boeblingen.de.ibm.com>
References: <20250904-iommu_succeed_attach_removed-v1-1-e7f333d2f80f@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250904-iommu_succeed_attach_removed-v1-1-e7f333d2f80f@linux.ibm.com>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDE5NSBTYWx0ZWRfX/zqCp+k2nO9L
 n8kluraprzWWkORc13LBGVR2O3mf+4G96R/CfOUG5dE7Z4L0maIDJLwblFu5DS13N56BBIlD6Nm
 oCIDkkC6EVmL+7DtubY9hWTocH//PDaI/D8SC5ppYLVv61RQm12yurB+tHjNQ/y2sa2yO+XBcWd
 fb7uvYdZLnQKaezH0JckNOpWpiru6y2M0XTMEDhyEbRalBFHwSaGrQFKDZfkHC2T9yFEgSo0Pk6
 M/Arjudp7EDqdii37teHT6SH6cUxpLiJePJT70eJoxDJ4zNX9ekn75E40itgI9e8N1FS2/Z0gjZ
 yEHl1V2ztPC94WhMCJZIxBx16tb8hsp8K6aRz4daG50SojPs7G25GkbYPZmcEbaY9L8bST2ZsH2
 y2Ro2a+h
X-Proofpoint-ORIG-GUID: YlekGEZfiKnv8ugEx6CF933gGtFBosBB
X-Proofpoint-GUID: YlekGEZfiKnv8ugEx6CF933gGtFBosBB
X-Authority-Analysis: v=2.4 cv=StCQ6OO0 c=1 sm=1 tr=0 ts=68c03123 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=8nJEP1OIZ-IA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=f94wAlES5zcTxHjwagAA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_02,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060195

On Thu, Sep 04, 2025 at 10:59:49AM +0200, Niklas Schnelle wrote:
> When a PCI device is removed with surprise hotplug, there may still be
> attempts to attach the device to the default domain as part of tear down
> via (__iommu_release_dma_ownership()), or because the removal happens
> during probe (__iommu_probe_device()). In both cases zpci_register_ioat()
> fails with a cc value indicating that the device handle is invalid. This
> is because the device is no longer part of the instance as far as the
> hypervisor is concerned.
> 
> Currently this leads to an error return and s390_iommu_attach_device()
> fails. This triggers the WARN_ON() in __iommu_group_set_domain_nofail()
> because attaching to the default domain must never fail.
> 
> With the device fenced by the hypervisor no DMAs to or from memory are
> possible and the IOMMU translations have no effect. Proceed as if the
> registration was successful and let the hotplug event handling clean up
> the device.
> 
> This is similar to how devices in the error state are handled since
> commit 59bbf596791b ("iommu/s390: Make attach succeed even if the device
> is in error state") except that for removal the domain will not be
> registered later. This approach was also previously discussed at the
> link.
> 
> Handle both cases, error state and removal, in a helper which checks if
> the error needs to be propagated or ignored. Avoid magic number
> condition codes by using the pre-existing, but never used, defines for
> PCI load/store condition codes and rename them to reflect that they
> apply to all PCI instructions.
> 
> Cc: stable@vger.kernel.org # v6.2

Oh, I just noticed that Niklas. You added `Cc: stable@vger.kernel.org`, but
didn't actually include the address on the actual Cc of the mail? Was that
intentional?


-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Wolfgang Wendt         /        Geschäftsführung: David Faller
Sitz der Ges.: Böblingen     /    Registergericht: AmtsG Stuttgart, HRB 243294
