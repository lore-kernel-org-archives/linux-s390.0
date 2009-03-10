Return-Path: <linux-kernel-owner+w=401wt.eu-S1754717AbZCJLSP@vger.kernel.org>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 09/25] [s390] BUG to BUG_ON changes
Date: Tue, 10 Mar 2009 12:17:54 +0100
References: <1236661850-8237-1-git-send-email-stoyboyker@gmail.com> <1236661850-8237-9-git-send-email-stoyboyker@gmail.com> <1236661850-8237-10-git-send-email-stoyboyker@gmail.com>
In-Reply-To: <1236661850-8237-10-git-send-email-stoyboyker@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200903101217.54927.borntraeger@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Stoyan Gaydarov <stoyboyker@gmail.com>
Cc: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Am Tuesday 10 March 2009 06:10:34 schrieb Stoyan Gaydarov:
> +++ b/drivers/s390/char/tape_std.c
> @@ -39,8 +39,8 @@ tape_std_assign_timeout(unsigned long data)
>  	int rc;
> 
>  	request = (struct tape_request *) data;
> -	if ((device = request->device) == NULL)
> -		BUG();
> +	device = request->device;
> +	BUG_ON(device == NULL);
> 
>  	DBF_EVENT(3, "%08x: Assignment timeout. Device busy.\n",
>  			device->cdev_id);

Most of the patch look good. Since !pointer seems to be preferred over 
pointer == NULL, this hunk can be changed to 

BUG_ON(!device);

Christian
