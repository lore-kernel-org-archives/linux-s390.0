Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C79155C93;
	Sat, 24 Aug 2024 05:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724476703; cv=none; b=nYiFJlVmdw19dTcYGhds7L+oHr7YvUo4yaqzN03IG0m/B82vXrUfXZ4J75qQs5/RzhLM+9m3pGj0XemGyc+Pc+MgJtijNP30KlcfDGTMO59IuIOKfbvOFxQ50dGTuMRWXeeTRgILHkOCrcbxWmYBbw16XncAdRczfv1ArtUReZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724476703; c=relaxed/simple;
	bh=kgyBdXsye1a/6QCni1L67UlqcPRlRzcDozumv00gwHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbCPflAPXvB0T569XfEc8lfQhDxdLSY9EAW0qxzCqM5J3i1FaIKebVfWPhr/Js65PH6gr5NYsWUO6GcrdPiZ5yonbFi2v+Eu46Wedu8hSRRHeWHSTJg5l6IlX9BheCzph6oDRqKAXv7YU7GUKPTazPV0+dBmZn11SxkqPDZkct0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l0BqcMWG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l0BqcMWG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2BC4C4AF10;
	Sat, 24 Aug 2024 05:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724476703;
	bh=kgyBdXsye1a/6QCni1L67UlqcPRlRzcDozumv00gwHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l0BqcMWGSsjpM+EUOhZSbc4ukSXDFYJUwVf3CfRY1TfJi7OQIYlSyfSS4qYRQ2SUL
	 Sy5OPcGcqJJ5naU87u+pEv6lWsqsYxUX2qu4Sx2g+Z7jkgGuXngi+0yxIXFn8M9w4g
	 adelqVwbS08L8XjkLtAw7rYO/4kPNiem7QqBqpbw=
Date: Sat, 24 Aug 2024 11:12:15 +0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, linux-s390@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH net v2] s390/iucv: Fix vargs handling in
 iucv_alloc_device()
Message-ID: <2024082405-dislocate-snowbound-3232@gregkh>
References: <20240820084528.2396537-1-wintera@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820084528.2396537-1-wintera@linux.ibm.com>

On Tue, Aug 20, 2024 at 10:45:28AM +0200, Alexandra Winter wrote:
> iucv_alloc_device() gets a format string and a varying number of
> arguments. This is incorrectly forwarded by calling dev_set_name() with
> the format string and a va_list, while dev_set_name() expects also a
> varying number of arguments.
> 
> Symptoms:
> Corrupted iucv device names, which can result in log messages like:
> sysfs: cannot create duplicate filename '/devices/iucv/hvc_iucv1827699952'
> 
> Fixes: 4452e8ef8c36 ("s390/iucv: Provide iucv_alloc_device() / iucv_release_device()")
> Link: https://bugzilla.suse.com/show_bug.cgi?id=1228425
> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
> Reviewed-by: Thorsten Winkler <twinkler@linux.ibm.com>
> ---

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
