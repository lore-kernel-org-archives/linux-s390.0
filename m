Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="NeQRDYF1"
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E13910DF
	for <linux-s390@vger.kernel.org>; Fri,  8 Dec 2023 20:53:59 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-7b70db00e64so54746439f.2
        for <linux-s390@vger.kernel.org>; Fri, 08 Dec 2023 20:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1702097638; x=1702702438; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q94zr7fXyaFSY0q/i8vffzz/BPsd7CsCP9j0O5HvOwM=;
        b=NeQRDYF195AhrxJL5WsTlTtgPvwr8ogJf80pkRIjQ/JBcG4CEKieVPcJP8YKtssrAs
         vPpiDlMOYSj7cCcQRuxz9KwKK8YJVgSck6m6e314GM2f7ayRYjJHxj+I94v4N9zGXfKx
         7PiglYar8uBvPhO3INQ5hGlwFSjFf/kgZqNbS/Skj8HhV5Egsr1QZcmcvYnfJlT9WWRk
         VvQZ7YzsFv+rtFhsszeUSFtJ8oAdTkQtyb3qK5lZTeOmMObMXwFklTcov5R1WN4ommcC
         mrDtogsKEtDE91qKK7mc6/8Gyh3GzYqCGLlPYKcFrTdL7HaiCH0vW5Fm4yuOOYiH/IbM
         Wtpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702097638; x=1702702438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q94zr7fXyaFSY0q/i8vffzz/BPsd7CsCP9j0O5HvOwM=;
        b=qrPLtLr89mArPlGr7kd/wSZ4yFCNwXG2ISq2y8ZWq/XUUdLNOukpJkoeroeua61zit
         ydIo71QjXtaqZhu5qxVg2tbieAEIEK9Vt6TCISZuiBT0aWlK+rO1mk4sMfv8IsnKmsf8
         yxkvywRA1Y6EQVxXLYritUjJo902qSKZjlaxkCCTtB1bn8hBiyqlETUMQSy4bYJtNlP+
         a9W5BZBTTg1UhnasMLbko3R6ZD/rAdMuFmV2DQXAjglJ8FS8lecG61kHMBuFYlZWSRJ9
         g81ksWwZiEmuGGMaFN2LWax8r6GrCvl05TBQnVRcys+DBQ71eRqzTWDQipXowl9TBXKb
         G0FQ==
X-Gm-Message-State: AOJu0YzyRz7nj9B7XwGNWddmZnJmBmEkK73AJri4syAsUk/p6fjbNY+M
	jRFnf4zdQD0SH+4Bu9kC1gN63w==
X-Google-Smtp-Source: AGHT+IHjlKWN++FniqDcZ6+gOzWsqUKFWZyGKGe7yDdh17gZNEzJGXsDiI4L8bI/oFVQrxwnnuY3mQ==
X-Received: by 2002:a05:6e02:1cae:b0:35d:5af6:5eb4 with SMTP id x14-20020a056e021cae00b0035d5af65eb4mr1632535ill.12.1702097638548;
        Fri, 08 Dec 2023 20:53:58 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id jg7-20020a17090326c700b001d0d312bc2asm2531341plb.193.2023.12.08.20.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 20:53:57 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rBpLf-005ozR-10;
	Sat, 09 Dec 2023 15:53:55 +1100
Date: Sat, 9 Dec 2023 15:53:55 +1100
From: Dave Chinner <david@fromorbit.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Zorro Lang <zlang@redhat.com>, linux-xfs@vger.kernel.org,
	linux-s390@vger.kernel.org, fstests@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>,
	Daniel Gomez <da.gomez@samsung.com>
Subject: Re: [Bug report] More xfs courruption issue found on s390x
Message-ID: <ZXPy4+cXlIt0agNz@dread.disaster.area>
References: <20231029043333.v6wkqsorxdk2dbch@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <ZUiHBpJTUr3G4//q@dread.disaster.area>
 <ZXO7gd3Ft1di8Okm@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXO7gd3Ft1di8Okm@bombadil.infradead.org>

On Fri, Dec 08, 2023 at 04:57:37PM -0800, Luis Chamberlain wrote:
> On Mon, Nov 06, 2023 at 05:26:14PM +1100, Dave Chinner wrote:
> > >   XFS: Assertion failed: ip->i_nblocks == 0, file: fs/xfs/xfs_inode.c, line: 2359
> >
> > IOWs, all four of these issues are the same problem - journal
> > recovery is not resulting in a correct and consistent filesystem
> > after the journal has been flushed at runtime, so please discuss and
> > consolidate them all in the initial bug report thread....
> 
> As recently reported, fortunately we now have reproducers for x86_64 too:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=218224
> 
> This fails on the following test sections as defined by kdevops [1]:
> 
>   * xfs_nocrc_2k
>   * xfs_reflink
>   * xfs_reflink_1024
>   * xfs_reflink_2k
>   * xfs_reflink_4k
>   * xfs_reflink_dir_bsize_8k
>   * xfs_reflink_logdev
>   * xfs_reflink_normapbt
>   * xfs_reflink_nrext64
> 
> [0] https://github.com/linux-kdevops/kdevops/blob/master/playbooks/roles/fstests/templates/xfs/xfs.config
> 
> Example failures:
> 
>   * generic/475: https://gist.github.com/mcgrof/5d6f504f4695ba27cea7df5d63f35197
>   * generic/388: https://gist.github.com/mcgrof/c1c8b1dc76fdc1032a5f0aab6c2a14bf
>   * generic/648: https://gist.github.com/mcgrof/1e506ecbe898b45428d6e7febfc02db1

If this is the same problem, have you tested whether the fix for the
s390 issue makes all the problems you are seeing on x86-64 go away?
i.e. commit 7930d9e10370 ("xfs: recovery should not clear di_flushiter
unconditionally")

-Dave.
-- 
Dave Chinner
david@fromorbit.com
