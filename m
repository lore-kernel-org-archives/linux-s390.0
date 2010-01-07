Return-Path: <linux-kernel-owner+w=401wt.eu-S1754172Ab0AGVq4@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
Subject: Re: s390 && user_enable_single_step() (Was: odd utrace testing
 results on s390x)
In-Reply-To: Martin Schwidefsky's message of  Thursday, 7 January 2010 10:18:55 +0100 <20100107101855.13248dc2@mschwide.boeblingen.de.ibm.com>
References: <20100104155225.GA16650@redhat.com>
	<20100104171626.22ea2d9c@mschwide.boeblingen.de.ibm.com>
	<20100104181412.GA21146@redhat.com>
	<20100104211147.4CC94D532@magilla.sf.frob.com>
	<20100105105030.66bb8a0a@mschwide.boeblingen.de.ibm.com>
	<20100105153633.GA9376@redhat.com>
	<20100105164610.388effd3@mschwide.boeblingen.de.ibm.com>
	<20100105155913.GA10652@redhat.com>
	<20100105170301.GA13641@redhat.com>
	<20100105195818.GA20358@redhat.com>
	<20100106201722.GB26204@redhat.com>
	<20100106211329.DB4F5134D@magilla.sf.frob.com>
	<20100107101855.13248dc2@mschwide.boeblingen.de.ibm.com>
Message-Id: <20100107214642.579F27300@magilla.sf.frob.com>
Date: Thu,  7 Jan 2010 13:46:42 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Oleg Nesterov <oleg@redhat.com>, caiqian@redhat.com, Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Kratochvil <jkratoch@redhat.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, utrace-devel@redhat.com
List-ID: <linux-s390.vger.kernel.org>

> Clear the TIF_SINGLE_STEP bit in copy_thread. If the new process is
> not auto-attached by the tracer it is wrong to delivere SIGTRAP to
> the new process.

The change is right, but this log entry is confusing.  "auto-attached" has
nothing to do with it, nor does anything about tracing the new process or
not.  The new process has not experienced a PER trap of its own, so it is
wrong to deliver a SIGTRAP that is meant for its creator.


Thanks,
Roland
