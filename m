Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2E17081E;
	Tue,  9 Sep 2025 14:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757428473; cv=none; b=IXfer9mjNrRXjUrUBGNadJx3Ml6/ZF1KhQ3RIflMpG6Q7uylO8t8zS0PcEZR01bRDj/v7mv5ZIGgGy1v/A1Ba/TcVEWKprTjeBz5A355aanCkZUiRmqQ5njndwdMqbHOIwi2cfUUXY8HDctiQaHaDeQ10ptD82ejaFrkbOjWk2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757428473; c=relaxed/simple;
	bh=WhObkg6w7OCH2C5BSXFjYBHV0zIX2r0flqPrQF44Wiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijpArAdLub8ZrSaOA1fsRW1mCS9kYtBASHIpOJgkWTClt1BamPkHKarzZkJO+Rnik41FvRnip7MwxjQLj56Q8NVW7ar/mi+BcHGk9cfUBQL4iOfSzFLgo5nZT5bB3NqIZkP08rUDz32U1gH+yxVm5uOB6tjKirq96rx4BV4GpAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cPICqP+r; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cPICqP+r"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5899mcUW005856;
	Tue, 9 Sep 2025 14:34:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:sender:subject:to; s=pp1;
	 bh=JLCOfqm5z+a3xj8AacGOp/niMNZy7BOWnXEfytTKa6M=; b=cPICqP+rqLMD
	MgME19YYsXP3+XKNTNSMfVXiOV0r/XjMylXW5/0f/4jIBpUs/WRVyG7NrQpRBq4i
	X5o5nWcx1vY1e28uQVyLL2ELt13m1A1IGwZTLe+WifDmtVfcXfpzoYdhiF1pcdq3
	+pHnsvGaQIdrAzhn1LPAz9FUZyvkER7AvgSVP6e1mp1vezE/Wfat9ZU7O8u2VmzZ
	i1bloSJZa7k9xkFrLDvYd3WJiFETzNVH3kYKehKyBQWtVkzuIYI3ajkS3bVkoyTP
	j5w+Z0sp3C5s6JBxvBwcPRiiXbrEzRosPC56n7TSo59NTVwP4kyebCqpZuA/1wvf
	6BXAzFstRQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490ukedk0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 14:34:25 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 589D1Iav020499;
	Tue, 9 Sep 2025 14:34:24 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 490yp0ur9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 14:34:24 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 589EYKXg58393048
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Sep 2025 14:34:20 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7AC0520040;
	Tue,  9 Sep 2025 14:34:20 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 697832004B;
	Tue,  9 Sep 2025 14:34:20 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.152.212.197])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  9 Sep 2025 14:34:20 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.98.2)
	(envelope-from <bblock@linux.ibm.com>)
	id 1uvzQK-00000000Xw0-0nl7;
	Tue, 09 Sep 2025 16:34:20 +0200
Date: Tue, 9 Sep 2025 16:34:20 +0200
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
Message-ID: <20250909143420.GB16134@p1gen4-pw042f0m.boeblingen.de.ibm.com>
References: <20250904-iommu_succeed_attach_removed-v1-1-e7f333d2f80f@linux.ibm.com>
 <20250909135230.GA16134@p1gen4-pw042f0m.boeblingen.de.ibm.com>
 <2265b28a92bace029a276bfefe6fd947c2a7bc7d.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2265b28a92bace029a276bfefe6fd947c2a7bc7d.camel@linux.ibm.com>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDE5NSBTYWx0ZWRfX3YhWUmo9p8KV
 dv4M+Tcys9iMApOvTxgR7bZslZixXHVokcSy0Lxd1B4+gQ2mrwmfgcx6QySR0L4//vIZfqi4Ds/
 pXElKihn1lXDk+iJJx7xqQDx7wY5c/UiyHNrp3ISNpS46Uz9KxT21DBfiNQktogz6t7tpD9krCt
 ouPZHTO1aCgsKAIqxGOegUNwm3U2EnasVMJ6X40s11a3MfLG97eDNcc7/tGGogOxVyU/yyExah2
 AGI3aBxfbZI1OUaw5Pb7tYA5lSNaiECqzSvKbVpyjnay4ne36yjt+quXTryb7zEWUuRM8ObcQfl
 0p4G1YkWqpzXAkyGGwSS8/XHH92ys2Q1+cvZ5NvqWHVI0FQOsMTBP/GxO2ep+HenRqUM3qbvq7e
 D/f3h3Do
X-Proofpoint-ORIG-GUID: 0GsSTKFzpDPeSYzOpSB3qjR16Ayb-to8
X-Proofpoint-GUID: 0GsSTKFzpDPeSYzOpSB3qjR16Ayb-to8
X-Authority-Analysis: v=2.4 cv=StCQ6OO0 c=1 sm=1 tr=0 ts=68c03af1 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=8nJEP1OIZ-IA:10 a=yJojWOMRYYMA:10 a=anyJmfQTAAAA:8 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=X9aRJ6VBdFPuLnTH-REA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_02,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060195

On Tue, Sep 09, 2025 at 04:05:48PM +0200, Niklas Schnelle wrote:
> On Tue, 2025-09-09 at 15:52 +0200, Benjamin Block wrote:
> > On Thu, Sep 04, 2025 at 10:59:49AM +0200, Niklas Schnelle wrote:
> > > Cc: stable@vger.kernel.org # v6.2
> > 
> > Oh, I just noticed that Niklas. You added `Cc: stable@vger.kernel.org`, but
> > didn't actually include the address on the actual Cc of the mail? Was that
> > intentional?
> > 
> 
> Yes it was intentional. It's my understanding that the tag is enough
> for the stable team to pick the commit up once it lands in Linus' tree.
> And I do have stable@vger.kernel.org explicitly ignored in b4 to
> prevent accidentally sending not-yet-ready or internal patches there.

Well, if it worked for you in the past, fair enough! I've always put it on Cc,
hence why I was wondering :)

> Sadly the docs don't spell out that Ccing the list isn't needed though
> I feel like it is implied by the "Cc: stable@kernel.org" variant where
> the docs mention that mails send by git send-email will go nowhere.

I think that part only means that address is basically /dev/null, even if a
mail is sent there. `git send-email` will try to include any address on such a
Cc tag by default
(https://git-scm.com/docs/git-send-email#Documentation/git-send-email.txt---suppress-cccategory)


-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Wolfgang Wendt         /        Geschäftsführung: David Faller
Sitz der Ges.: Böblingen     /    Registergericht: AmtsG Stuttgart, HRB 243294
