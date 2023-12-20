Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19710168CF;
	Wed, 20 Dec 2023 07:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c7hUcWBW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2745FC433C8;
	Wed, 20 Dec 2023 07:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703057084;
	bh=vgYQHXoBYQ7wQ7dKTUVuiNyeocofAoyCY4vb5t7hD0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c7hUcWBWpR0G15uXayfEHAucp0eeMFVTuEBNvQbBfQ3wnyv7jLXO+/eg2/+/a5G79
	 VYVNMIzva2Kteua7Vp5SuuS44aB6//ECgCvAEDGhuPQsedqxVYllCbsatLjFhgO2kO
	 ltxMYJbCUrXm/kE9Q0i3eznNwq+49neCz2CPhbSE=
Date: Wed, 20 Dec 2023 08:24:42 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: wintera@linux.ibm.com, wenjia@linux.ibm.com,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] icuv: make iucv_bus const
Message-ID: <2023122030-faceless-refutable-6d17@gregkh>
References: <2023121950-prankster-stomp-a1aa@gregkh>
 <8ab61ee331b8087b8a26a2a38b3ae0c72cc31bb0.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ab61ee331b8087b8a26a2a38b3ae0c72cc31bb0.camel@linux.ibm.com>

On Tue, Dec 19, 2023 at 04:25:13PM +0100, Niklas Schnelle wrote:
> On Tue, 2023-12-19 at 16:07 +0100, Greg Kroah-Hartman wrote:
> > Now that the driver core can properly handle constant struct bus_type,
> > move the iucv_bus variable to be a constant structure as well, placing
> > it into read-only memory which can not be modified at runtime.
> > 
> > Cc: Alexandra Winter <wintera@linux.ibm.com>
> > Cc: Wenjia Zhang <wenjia@linux.ibm.com>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Eric Dumazet <edumazet@google.com>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Paolo Abeni <pabeni@redhat.com>
> > Cc: linux-s390@vger.kernel.org
> > Cc: netdev@vger.kernel.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> 
> Nit: There seems to be a typo in the subject line s/icuv/iucv/

Ugh, good catch, let me go send a v2, thanks!

greg k-h
