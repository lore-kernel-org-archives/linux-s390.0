Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B60E43785D;
	Mon, 21 Sep 2026 10:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789985235; cv=none; b=WEDNn4QYxJa1rxA4oYMU/IrKSPuqq6BZJ2G6xjwVxpCD5aT8gKedUdSB5yC8/03TAGOl2/uxpd/vDkmRJtmb2XQ3IXMfA3jwiS7qf1j5wF4fm8XhD1pfzLqkmRlO2xZtM0t4bwKKomSU/w3vGwhyLo2siB8tKJVWHJPjukWR9Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789985235; c=relaxed/simple;
	bh=vagw47KRwwiyR7K2FeW9GOnfJtzNFFxIq6+7K6nhpeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MrpdOTS9VGjs+/a2Rk3d135iD0m8XVttsJrQnvAMbUp7IJqzHaMsPw5nZYPb8D0V4befNLfhaSK0XLjNBR1+39/xBNnYNsZvD+jbblDVbI2bhlNri9B4aWknx11CFGD6tKPZP4j4Z0ufTEMiKVr/sfceQhfEuTlL18toJxTbdYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Qws4J7vy; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Qws4J7vy"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D6A31CE0;
	Mon, 21 Sep 2026 03:07:09 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B23473F86C;
	Mon, 21 Sep 2026 03:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789985232; bh=vagw47KRwwiyR7K2FeW9GOnfJtzNFFxIq6+7K6nhpeI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qws4J7vyKIO4G+F2UOBiB3pXFlnMLFnijYHl05JztYTW3J3TRo2Epq+D+P34o4ZQ1
	 PqSm5oGOLh9Zic0jwZ6ZO3AphSE2laa9Hg3z/wB2fRQYZlDhxxzPdxxImxWtWj7j4K
	 aKDZt04QoPELSZo/XIzsWrbWdNb8XQhZbOyTKGrI=
Date: Mon, 21 Sep 2026 11:07:04 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Mete Durlu <meted@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juergen Christ <jchrist@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 11/11] s390/percpu: Rework to simplify percpu_entry()
 and percpu_exit()
Message-ID: <arEByH7VvkEvy9Fk@J2N7QTR9R3>
References: <20260921084005.4022574-1-hca@linux.ibm.com>
 <20260921084005.4022574-12-hca@linux.ibm.com>
 <20260921105518.26f3dcf7@pumpkin>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921105518.26f3dcf7@pumpkin>

On Mon, Sep 21, 2026 at 10:55:18AM +0100, David Laight wrote:
> On Mon, 21 Sep 2026 10:40:05 +0200
> Heiko Carstens <hca@linux.ibm.com> wrote:

> > +	regpcp = FIELD_GET(PCPU_REG_PCP, regval);
> > +	regoff = FIELD_GET(PCPU_REG_OFF, regval);
> ...
> > +#define PCPU_REG_PCP_SHIFT		0
> > +#define PCPU_REG_PCP			GENMASK(3, 0)
> > +#define PCPU_REG_OFF_SHIFT		4
> > +#define PCPU_REG_OFF			GENMASK(7, 4)
> ...
> > +#define __PCPU_CALC_REGVAL(regpcp, regoff)					\
> > +	"(" regpcp " << " __stringify(PCPU_REG_PCP_SHIFT) ") |"			\
> > +	"(" regoff " << " __stringify(PCPU_REG_OFF_SHIFT) ")"
> 
> I'm not a big fan of GENMASK() + FIELD_GET() and I'm not at all sure it
> really helps here.

It's the same pattern already used by the extable code. 

While _you_ don't like it, that's not a universal opinion (and FWIW, I
prefer the FIELD_GET() approach).

I'll leave it to Heiko and co to choose whatever style they prefer, as
it's their architecture port...

Mark.
