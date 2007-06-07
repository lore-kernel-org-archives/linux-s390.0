Return-Path: <linux-kernel-owner+w=401wt.eu-S1760432AbXFGHEQ@vger.kernel.org>
Message-ID: <4667ADDA.2070202@de.ibm.com>
Date: Thu, 07 Jun 2007 09:03:54 +0200
From: Martin Peschke <mp3@de.ibm.com>
MIME-Version: 1.0
Subject: Re: [RFC] [Patch 4/4] lock contention tracking slimmed down
References: <1181165656.7133.23.camel@dix> <20070606230641.GA11592@elte.hu> <46674EA9.9090601@de.ibm.com> <20070607044017.GA3828@gnuppy.monkey.org>
In-Reply-To: <20070607044017.GA3828@gnuppy.monkey.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, a.p.zijlstra@chello.nl, jbaron@redhat.com, rostedt@goodmis.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Bill Huey (hui) wrote:
 > There are roughly about 400 locks in a normal kernel for a desktop. The
 > list is rather cumbersome anyways so, IMO, it really should be handled
 > by parsing tools, etc... There could be more properties attached to each
 > lock especially if you intend to get this to work on -rt which need more
 > things reported.

Adding stuff to an already wide table in a readable fashion is more difficult
than making a list longer.

Do mean I might submit this stuff for -rt?
