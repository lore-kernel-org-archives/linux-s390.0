Return-Path: <linux-kernel-owner+w=401wt.eu-S1757338AbXFGHve@vger.kernel.org>
Subject: Re: [RFC] [Patch 4/4] lock contention tracking slimmed down
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
In-Reply-To: <1181165656.7133.23.camel@dix>
References: <1181165656.7133.23.camel@dix>
Content-Type: text/plain
Date: Thu, 07 Jun 2007 09:51:23 +0200
Message-Id: <1181202683.7348.220.camel@twins>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Peschke <mp3@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, jbaron@redhat.com, rostedt@goodmis.org, billh@gnuppy.monkey.org, mingo@elte.hu, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 2007-06-06 at 23:34 +0200, Martin Peschke wrote:

> +struct statistic_info lock_stat_info[_LOCK_STAT_NUMBER] = {
> +	[LOCK_STAT_CONT] = {
> +		.name	  = "contentions",
> +		.x_unit	  = "instruction_pointer",
> +		.y_unit	  = "occurrence",
> +		.defaults = "type=sparse entries=4",
> +		.flags	  = STATISTIC_FLAGS_LABEL,
> +	},
> +	[LOCK_STAT_WAIT_READ] = {
> +		.name	  = "wait_read",
> +		.x_unit	  = "nanoseconds",
> +		.y_unit	  = "occurrence",
> +		.defaults = "type=utilisation",
> +	},
> +	[LOCK_STAT_WAIT_WRITE] = {
> +		.name	  = "wait_write",
> +		.x_unit	  = "nanoseconds",
> +		.y_unit	  = "occurrence",
> +		.defaults = "type=utilisation",
> +	},
> +	[LOCK_STAT_HOLD_READ] = {
> +		.name	  = "hold_read",
> +		.x_unit	  = "nanoseconds",
> +		.y_unit	  = "occurrence",
> +		.defaults = "type=utilisation",
> +	},
> +	[LOCK_STAT_HOLD_WRITE] = {
> +		.name	  = "hold_write",
> +		.x_unit	  = "nanoseconds",
> +		.y_unit	  = "occurrence",
> +		.defaults = "type=utilisation",
>  	}
>  };

You're parsing strings in-kernel to setup data structures?
