Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324891C68C
	for <linux-s390@vger.kernel.org>; Thu,  4 Apr 2024 14:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712242615; cv=none; b=WTIA9BrTojNyQxZ7U8DCKfUUUqledlEXyW4tm6JYeaxmlDKTdR623U/RMUXoZu0IpfZD1JSIQe7e6jWTeGFaHe6pQWUS26CCM2ZIxHaAdU33GMPGovST5eRokXbqBO8xctESzHbgdcKnh/Zxmon9gt/+lk3zeOH+A/25VFfbsGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712242615; c=relaxed/simple;
	bh=fuDd+HFyND9G6HPXN8Zppo06oelLFc9HJWZBWUJI2LA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eaDq89CyXxwhVNpXuZti93QTRC8t6EQ45eCy83UwJLjg/wlG0ZUkmMYjORgPI96KsT1TpBhNWTLUG5o40nQmAYDvFW0EaEyXG6omA9kmkGd4YaRWqx7sHCaU6Ww7NsSnI7D09oxMgd13VAvcE85UfOFjzTfCFw8CiOseZxx7ZEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UDivKTfd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UDivKTfd"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 434EINXJ017808;
	Thu, 4 Apr 2024 14:56:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=5Zfpe6oWhfW4sW6J1O2VoKZ7ZJWinYmtxRJeM4U3kT0=;
 b=UDivKTfdDU61hcnqbqnLJLen20YUObYu+CBTXRvMQG6VnNrKdgrkYxv5Lenh1GQYzbrk
 xwizfdg2OkQ7LUPyw1cqtwzM0elmgzGKDG34OLWBlUpXkj1Rxfc8TH4tt3MjegtxtMwX
 f5Yn4ZCqReFvMdl4iqNXClShMYJEuELquXbujen9wJVZ/sQ6rEJigbQPkFwC4EDE7sbH
 Gd/DEKfdAsSWCSQNOtVIbOTe1W22nx1l2y+/ZYMLUMfOZVp96vD5THHGVD5wibEyZlVP
 irUfJXiHDhesBJo9Co957afvunUWhmoq6CJss8NavZZ16PISRd4yNTlfCm2D1lT4rCBh 7w== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x9wuk83qd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 14:56:45 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 434DgYkN022293;
	Thu, 4 Apr 2024 14:56:45 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x9eq0cr8f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 14:56:45 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 434Eudax17629522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Apr 2024 14:56:41 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D67620043;
	Thu,  4 Apr 2024 14:56:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE33220040;
	Thu,  4 Apr 2024 14:56:38 +0000 (GMT)
Received: from p-imbrenda (unknown [9.171.24.188])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu,  4 Apr 2024 14:56:38 +0000 (GMT)
Date: Thu, 4 Apr 2024 16:56:36 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Vasily
 Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/2] Convert some gmap functions to use folios
Message-ID: <20240404165636.3d8eb24f@p-imbrenda>
In-Reply-To: <Zg6tb7DMYGF57o2i@casper.infradead.org>
References: <20240322161149.2327518-1-willy@infradead.org>
	<20240326074127.6078-B-hca@linux.ibm.com>
	<Zg6tb7DMYGF57o2i@casper.infradead.org>
Organization: IBM
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WaylIibrGnNWblpLvLZkOd1u0uJdFsNK
X-Proofpoint-GUID: WaylIibrGnNWblpLvLZkOd1u0uJdFsNK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_10,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=981
 impostorscore=0 bulkscore=0 clxscore=1011 suspectscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404040103

On Thu, 4 Apr 2024 14:38:55 +0100
Matthew Wilcox <willy@infradead.org> wrote:

> On Tue, Mar 26, 2024 at 08:41:27AM +0100, Heiko Carstens wrote:
> > On Fri, Mar 22, 2024 at 04:11:45PM +0000, Matthew Wilcox (Oracle) wrote:  
> > > struct page is going to lose its refcount (someday) and as part of
> > > that page_ref_freeze() will go away.  s390's ultravisor is one of
> > > the few remaining places that uses it, so convert it over to folios.
> > > From previous interactions, I understand that ultravisor doesn't support
> > > large folios, so this simply declines to make large folios secure.
> > > I think you'd be better off splitting the folio if it is large, but
> > > that's something I'd rather leave to someone who can test it.  
> > 
> > Christian, Janosch, or Claudio, could you have a look at this please;
> > and provide an ACK if this is ok with you?  
> 
> Ping?

hi,

we've been looking into it and running some tests to see if anything
catches fire. I thought someone had replied to tell you, but apparently
it should have been me, and I forgot :)


you can tack this on:

Acked-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
