From: Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [RFC PATCH-tip v4 10/10] locking/rwsem: Add a boot parameter to
 reader spinning threshold
Date: Tue, 23 Aug 2016 21:00:07 -0700
Message-ID: <20160824040007.GA17186@linux-80c1.suse>
References: <1471554672-38662-1-git-send-email-Waiman.Long@hpe.com>
 <1471554672-38662-11-git-send-email-Waiman.Long@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-ia64-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1471554672-38662-11-git-send-email-Waiman.Long@hpe.com>
Sender: linux-ia64-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Waiman Long <Waiman.Long@hpe.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, Jason Low <jason.low2@hp.com>, Dave Chinner <david@fromorbit.com>, Jonathan Corbet <corbet@lwn.net>, Scott J Norton <scott.norton@hpe.com>, Douglas Hatch <doug.hatch@hpe.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 18 Aug 2016, Waiman Long wrote:

>The default reader spining threshold is current set to 4096. However,
>the right reader spinning threshold may vary from one system to
>another and among the different architectures. This patch adds a new
>kernel boot parameter to modify the threshold value. This enables
>better tailoring to the needs of different systems as well as for
>testing purposes.

It also means that those systems could very easily be incorrectly tailored.
(and worse case scenario: reboot, is obviously a terrible way to get rid
of any issues). I very much disagree with exposing this sort of core stuff,
it should work well for everyone out of the box, not relying on users to
properly configure this.

Thanks,
Davidlohr
