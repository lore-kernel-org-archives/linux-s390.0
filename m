Return-Path: <linux-kernel-owner+w=401wt.eu-S965945AbXFGAcs@vger.kernel.org>
Message-ID: <46675222.9000304@de.ibm.com>
Date: Thu, 07 Jun 2007 02:32:34 +0200
From: Martin Peschke <mp3@de.ibm.com>
MIME-Version: 1.0
Subject: Re: [RFC] [Patch 1/4] statistics: no include hell for users
References: <1181165609.7133.20.camel@dix> <1181165987.22388.81.camel@spirit.sr71.net>
In-Reply-To: <1181165987.22388.81.camel@spirit.sr71.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Dave Hansen <hansendc@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, a.p.zijlstra@chello.nl, jbaron@redhat.com, rostedt@goodmis.org, billh@gnuppy.monkey.org, mingo@elte.hu, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Dave Hansen wrote:
> On Wed, 2007-06-06 at 23:33 +0200, Martin Peschke wrote:
>>  struct statistic_interface {
>>  /* private: */
>>         struct list_head         list;
>> -       struct dentry           *debugfs_dir;
>> -       struct dentry           *data_file;
>> -       struct dentry           *def_file;
>> +       void                    *debugfs_dir;
>> +       void                    *data_file;
>> +       void                    *def_file; 
> 
> If you don't actually dereference the pointer, you should just be able
> to declare:
> 
> 	struct dentry;
> 
> and be done with it, right?  You don't _need_ the includes to have just
> pointers.

Ah, looks like an established trick in kernel include files.
I guess I can revert the other, seq_file related change then as well.
Thank you. Will change my local copy.

Martin
