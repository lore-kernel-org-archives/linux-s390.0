Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0481B4120
	for <linux-s390@vger.kernel.org>; Thu,  2 Jan 2025 15:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735831665; cv=none; b=dq0e4rOHlHKUydg+hd9emM1hNQ+nzbOt3ZbwNz1IneDao0Iy/kZUFxc0h6WqW/vbMnZbI3r1aJabyTcvF/ErjSrXizv9kWsF0vZkRpJ8ylJ95mkOWEQrJ7oGI9b/ttmEMM65a6naZomyvRMZBRm450UNiaoSLCvY+o8+lLXdYJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735831665; c=relaxed/simple;
	bh=n+Gj8NdzfT6j/tuL1ZIoARiw552+ZjcUH8ctsmzGD2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBCd5pYewik3mQXJWex2JUzCCGRj6zS4fNcGLIL7hiC0rcGkgwdM6kTkKPm3leRJPCWakWQceAYAUd7cH4e/hWZpfZzcJmQWAR6P5vYzJQt0ts2VLhOnsaKui8rhBEPNKp79GySQh+E7UR9/kN/n7+4k2TUDoWH3cZfANCmg7rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Nvsjs2o/; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Nvsjs2o/"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4362f61757fso114337715e9.2
        for <linux-s390@vger.kernel.org>; Thu, 02 Jan 2025 07:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1735831661; x=1736436461; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=05upqEVJPolnyr/HoSHZRKWoniI8eKda58PhaQdla5Y=;
        b=Nvsjs2o/GLN5+oGmb64SN7c3a5HDtS8oU2w1l2X0BGXj+J7C67dJSQeEP2J0eIi/va
         DPg9FkqXtNEbpjGKZskeuYeeGl+h2odl4et+tnPWVHJzezneb5V7nOrBGRXVWBINHvaP
         GWtYwQid70k4s2Vk3cUPMb8/kaPBvlAH6LqkV4Re4qcyC2FBFzCqezPqRBvrtp3tq9m5
         IFYellCDkg5ySJLoVZCZvfumtgdhhRH0UQzNwtX8zUZm1CHonSWY3K4taNJgWOLelLrz
         oNssUzAAsUVxpXHbHWG/yOxj+A3bT4zR1vfrhYrRRAQiu+IbqTvkQRH6HJxMgpVGCfJv
         b/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735831661; x=1736436461;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=05upqEVJPolnyr/HoSHZRKWoniI8eKda58PhaQdla5Y=;
        b=Ig8vmYHIwtOlQeJV8nIwAOvu9KY8brQwCLY7NS8d7ZaPcWBSV5Dnlt/3kHU2FwQau7
         jrxCeCRP7gsvXJvQULX5xBt5/P3GAAdavV46UlmcT95OrsSILDz/0x9XZmiWtAS9GCX6
         F6WusvPN5fPbqX99NeXk4dRG2Wc/43tfASwGMDxjeQx7MibiKhNa3egfISGPUEvKPj7P
         +XL+jRj4+7AzeIF6sjxjGYpXd8fifBYE3lDKMZTC6h+lMhucXJqSdv0U5CE6Ahx+9bYJ
         SsJSxVp5UgehtvqNne2v+1VpWRGV9L7ho+OCYMoK6ekDEeulvspHpM16IEQVpa+pS1SP
         QT7g==
X-Forwarded-Encrypted: i=1; AJvYcCUUsfV99bu3aXrd+PPbaDXItqj9eZn8P7pdOfU75KyTdSD/MF28sk7I7OgFZflEBSjWlNgbG2WoTvkM@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2Vxay4tW8DBa094s2DGKZj+UsUNNy/ZSRMPSjnvgOsfPKhLXl
	bayJEQRM9iqPxoyA34y5DytWfhCMlgzdCu6JGC10x8ehyDTKM3oe2v9dR0daum4=
X-Gm-Gg: ASbGncvJaNSk5tmYIr3qdqpFSywex0Ffp7RZiTHfUDpnJDdQABezrPBLDN4y2pa6ntt
	0h3xZp7KAn0cbIKopKJQBQKmLRaDNrGCjr4bxYrFNcdT+DB648KhpwAC2x0OTh4hLIWORfUiT2Z
	qSqvKYUbJD+05c5JKgwVzsnCu7U2u+jdzgon9jqnpStMA6puKP27kpSIeWduoR8VpVx6NxUrimz
	jcS6/JsSRsUnJgpOmvTr760Kzjf0z9q47hz9VSdnZPEDkPfA/xsW/kEAw==
X-Google-Smtp-Source: AGHT+IFcM1oKMh1kjxBO7ycMH/tQaCFmKpK0dg2zqRMgKTMW78Q/ZGzddqirXlD2dJ4tXVJnV9Cs1Q==
X-Received: by 2002:a05:600c:35d2:b0:435:d22:9c9e with SMTP id 5b1f17b1804b1-43668646335mr389612275e9.19.1735831660707;
        Thu, 02 Jan 2025 07:27:40 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43661218f43sm458314275e9.19.2025.01.02.07.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 07:27:39 -0800 (PST)
Date: Thu, 2 Jan 2025 16:27:36 +0100
From: Petr Mladek <pmladek@suse.com>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
	Joe Lawrence <joe.lawrence@redhat.com>, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v4 2/2] livepatch: Convert timeouts to secs_to_jiffies()
Message-ID: <Z3awaFzhgvY3bypu@pathway.suse.cz>
References: <20241217231000.228677-1-eahariha@linux.microsoft.com>
 <20241217231000.228677-3-eahariha@linux.microsoft.com>
 <Z2KJ8C7nOOK2tJ1X@pathway.suse.cz>
 <f54d34f8-05cd-4081-92a2-85df3f76a35b@csgroup.eu>
 <195abda2-8209-45aa-9652-f981a5de2eae@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <195abda2-8209-45aa-9652-f981a5de2eae@linux.microsoft.com>

On Wed 2024-12-18 09:35:46, Easwar Hariharan wrote:
> On 12/18/2024 12:48 AM, Christophe Leroy wrote:
> > 
> > 
> > Le 18/12/2024 à 09:38, Petr Mladek a écrit :
> >> On Tue 2024-12-17 23:09:59, Easwar Hariharan wrote:
> >>> Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
> >>> secs_to_jiffies(). As the value here is a multiple of 1000, use
> >>> secs_to_jiffies() instead of msecs_to_jiffies to avoid the
> >>> multiplication.
> >>>
> >>> This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci
> >>> with
> >>> the following Coccinelle rules:
> >>>
> >>> @@ constant C; @@
> >>>
> >>> - msecs_to_jiffies(C * 1000)
> >>> + secs_to_jiffies(C)
> >>>
> >>> @@ constant C; @@
> >>>
> >>> - msecs_to_jiffies(C * MSEC_PER_SEC)
> >>> + secs_to_jiffies(C)
> >>>
> >>> While here, replace the schedule_delayed_work() call with a 0 timeout
> >>> with an immediate schedule_work() call.
> >>>
> >>> --- a/samples/livepatch/livepatch-callbacks-busymod.c
> >>> +++ b/samples/livepatch/livepatch-callbacks-busymod.c
> >>> @@ -44,8 +44,7 @@ static void busymod_work_func(struct work_struct
> >>> *work)
> >>>   static int livepatch_callbacks_mod_init(void)
> >>>   {
> >>>       pr_info("%s\n", __func__);
> >>> -    schedule_delayed_work(&work,
> >>> -        msecs_to_jiffies(1000 * 0));
> >>> +    schedule_work(&work);
> >>
> >> Is it safe to use schedule_work() for struct delayed_work?
> > 
> > Should be, but you are right it should then be a standard work not a
> > delayed work.
> > 
> > So probably the easiest is to keep
> > 
> >     schedule_delayed_work(&work, 0)
> > 
> > And eventually changing it to a not delayed work could be a follow-up
> > patch.
> > 
> >>
> 
> Thanks for the catch, Petr! This suggestion would effectively revert
> this patch to the v3 version, albeit with some extra explanation in the
> commit message. I'd propose just keeping the v3 in the next branch where
> it is.
> 
> Andrew, Petr, Christophe, what do you think?

I am fine with keeping v3 in next.

Best Regards,
Petr
