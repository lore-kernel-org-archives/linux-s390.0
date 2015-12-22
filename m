Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 22 Dec 2015 06:58:50 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH] s390/vmur: fix build warning
Message-ID: <20151222065850.GA20997@ZenIV.linux.org.uk>
References: <1450767231-21039-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1450767231-21039-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Dec 22, 2015 at 12:23:51PM +0530, Sudip Mukherjee wrote:
> The helper no_seek_end_llseek() was added but now newpos is not required
> and as a result we are getting build warning of unused variable.

Mind if I simply fold that into the commit in question?
