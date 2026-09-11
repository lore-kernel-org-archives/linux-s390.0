Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D7C2BDC0E;
	Fri, 11 Sep 2026 16:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789143883; cv=none; b=YUd51L/tvy53eMfgz5P58aF8BYeWLcx+Ppi3sLaAz/2no0oc998V/iW2Tq12pvGyJDlt2J22HhH1bVhSAOzggxAWcFizMM7tTVCzD2YKBAvZX581A3kVnaPH0BL9uVVqlBrTH7bzKlXWVAeaYrYlntsUeNUZkNl+EYdMdzMOIwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789143883; c=relaxed/simple;
	bh=7E9ljFEWS2EnS8zFz++HrgjZGtNaw+J3s4bfHZU/yWo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z4J0O54hmP7h69wwqQQoL0Rlwotn9Ik6M668ALhaNNfP3vcQGTYbCTArfr0SSqOo44wEUNwL5cg1RALqpEgpvfg97TNqqXKb3Ogy9sumekWkKIsxUGwGg+Iq1LcU5fa/Otql/87MW6npCNGV0SHZ3isVnmNyzcj7kwM0Kq1KLeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCeJpyW7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCeJpyW7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D00B81F000FF;
	Fri, 11 Sep 2026 16:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789143882;
	bh=mETSPQtevQ9k52lQxxVbsqJk19LnNtr2VJD9XrMFhpk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JCeJpyW732vD8iy5bYSHlFYRUa1GYc3RpkJDRYD1ICFG3mgrmnLVU0PBfDqO9Qrss
	 buW/n8fBMNjCIJZYL6fHQxW8vPZcxRC5dbfSIi/Q0jxilBGTuTJpP9MJHQABILA7F/
	 ZVIyb87yTRQGQrCdnQtXiz36/rfH06NQcifFocqUb79NvHfeR11+AizD3cn0zpVQ3y
	 RlwfYAFkhBC7REMz4xMeOaJWqyYT/DC4mTOk5G/Uz13gLDkHbBtmebjWzD4s64Spub
	 Qc4YO3zTTHb4emUfjmq6rmHgXVQwZl8E+FjcEJIYGQO9yEbsqFzy0MJasfoKiEy362
	 ZSuFiQcKQAbDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tracing: Don't dereference trace_event_file in deferred
 trigger free
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QWxpIEFobWV0IE1lbWnFnw==?= <aliamemis@disroot.org>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-trace-kernel@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260911155650.354844-1-aliamemis@disroot.org>
References: <20260911155650.354844-1-aliamemis@disroot.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 16:24:41 +0000
Message-Id: <20260911162441.D00B81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] trace_event_file UAF and trigger memory leak on module unload
--

commit a41f148580cfeaf3b10b318f7d55d016bb4307cc
Author: Ali Ahmet Memi=C5=9F <aliamemis@disroot.org>

tracing: Don't dereference trace_event_file in deferred trigger free

This commit addresses a use-after-free by avoiding the dereference of
trace_event_file during a deferred trigger free. It does so by directly
keeping the trace_event_call in the enable_trigger_data structure.

Link: https://lore.kernel.org/all/20260828134340.2501683A24-agordeev@linux.=
ibm.com/

> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 5e76f94e7a80e..0e4baecc7c737 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -1952,6 +1952,7 @@ struct event_trigger_data {
> =20
>  struct enable_trigger_data {
>  	struct trace_event_file		*file;
> +	struct trace_event_call		*call;
>  	bool				enable;
>  	bool				hist;
>  };
> diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_eve=
nts_trigger.c
> index 149300cc5e8ad..4d2fde996c0f6 100644
> --- a/kernel/trace/trace_events_trigger.c
> +++ b/kernel/trace/trace_events_trigger.c
> @@ -1728,7 +1728,8 @@ static void enable_trigger_private_data_free(struct=
 event_trigger_data *data)
>  {
>  	struct enable_trigger_data *enable_data =3D data->private_data;
> =20
> -	trace_event_put_ref(enable_data->file->event_call);
> +	/* The file may already be freed here, only the call is kept alive */
> +	trace_event_put_ref(enable_data->call);

[Severity: High]
This isn't a bug introduced by this patch, but it is a preexisting issue in
the subsystem's module unload handling.

When a privileged user registers a trace event trigger (like traceon or
enable_event) on a trace event defined in a kernel module and then unloads
that module, trace_module_remove_events() removes the events and eventually
frees the trace_event_file structure synchronously:

kernel/trace/trace_events.c:remove_event_file_dir() {
...
	file->flags |=3D EVENT_FILE_FL_FREED;
	event_file_put(file);
...
}

kernel/trace/trace_events.c:event_file_put() {
...
	if (refcount_dec_and_test(&file->ref)) {
		/* Count should only go to zero when it is freed */
		if (WARN_ON_ONCE(!(file->flags & EVENT_FILE_FL_FREED)))
			return;
		kmem_cache_free(file_cachep, file);
	}
}

Does this code leak the file->triggers list and cause memory corruption?

Because remove_event_file_dir() does not wait for an RCU grace period via
tracepoint_synchronize_unregister() before freeing the file, couldn't
concurrent RCU readers executing the tracepoint probe dereference the freed
file pointer?

Also, without cleaning up the triggers attached to file->triggers, are these
trigger structures permanently leaked?

>  	kfree(enable_data);
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911155650.3548=
44-1-aliamemis@disroot.org?part=3D1
