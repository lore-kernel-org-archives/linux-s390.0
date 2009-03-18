Return-Path: <linux-kernel-owner+w=401wt.eu-S1757315AbZCRPIh@vger.kernel.org>
Subject: PROBLEM: relay - stale data copied to user space
From: Martin Peschke <mpeschke@linux.vnet.ibm.com>
Content-Type: text/plain
Date: Wed, 18 Mar 2009 16:07:28 +0100
Message-Id: <1237388848.4084.64.camel@kitka.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tom Zanussi <tzanussi@gmail.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi,

Tracing block I/Os using blktrace and blkiomon results in "bad trace"
messages, meaning that user space has come across a trace which is
broken:

bad trace magic 100
bad trace magic 10e7
bad trace magic 1
bad trace magic 1
bad trace magic 374
bad trace magic 7000010
bad trace magic 11000010
bad trace magic 1000
bad trace magic 10e3
bad trace magic 0
bad trace magic 1000
bad trace magic 10de
bad trace magic 8b3
bad trace magic 0

This condition can't be recovered from because blktrace has lost track
of where the next valid trace is.

I gathered hexdumps of blktrace data in user space. Looking at the data
as read by blktrace from relay files, I found fragments of old traces
partially overlaying other traces:

(In the hexdump-ed trace below, I have added "|"s as delimiters between
traces. The corrupted part of the trace - a fragment containing the
sequence number 0x4d1d3 - is in parenthesis.)

12d8ca0 |6561 7407 0005 6440 0000 00fb ef9d 6496  -> sequence 0x56440
12d8cb0  0000 0000 000f 4790 0002 0000 4001 0011
12d8cc0  0000 1445 0080 0020 0000 0001 0000 0018
12d8cd0  0000 0001 0001 007d 0000 0000 0001 3e40
12d8ce0  0000 0000 001b badc|6561 7407 0005 6441  -> sequence 0x56441
12d8cf0  0000 00fb ef9d 79e3 0000 0000 000f 4790
12d8d00  0002 0000 0181 0008 0000 1445 0080 0020
12d8d10  0000 0001 0000 0000|6561 7407 0005 6442  -> sequence 0x56442
12d8d20 (0000 1444 0080 0020 0000 0001 0000 0000
12d8d30 |6561 7407 0004 d1d3 0000 00e3 4a8b 1544  -> sequence 0x4d1d3
12d8d40  0000 0000 0015 5728 0003 0000 4001 0011     old trace!!
12d8d50  0000 1447 0080 0020 0000 0001 0000 0018)
12d8d60 |6561 7407 0005 6443 0000 00fb f04d c32a  -> sequence 0x56443
12d8d70  0000 0000 000f 4928 0000 8000 4001 0011
12d8d80  0000 1445 0080 0020 0000 0001 0000 0018
12d8d90  0000 0001 0001 007f 0000 0000 0000 55d8
12d8da0  0000 0000 0008 1070|6561 7407 0005 6444  -> sequence 0x56444

The same fragment containing sequence 0x4d1d3 originally appeared in
this context:

10d8d70  0000 0000 0013 970e|6561 7407 0004 d1d2  -> sequence 0x4d1d2
10d8d80  0000 00e3 4a82 8773 0000 0000 0039 4d20
10d8d90  0001 0000 0181 0008(0000 1444 0080 0020
10d8da0  0000 0001 0000 0000|6561 7407 0004 d1d3  -> sequence 0x4d1d3
10d8db0  0000 00e3 4a8b 1544 0000 0000 0015 5728
10d8dc0  0003 0000 4001 0011 0000 1447 0080 0020
10d8dd0  0000 0001 0000 0018)0000 0001 0001 0080
10d8de0  0000 0000 0001 156c 0000 0000 001a 10c8
10d8df0 |6561 7407 0004 d1d4 0000 00e3 4a8b 239c  -> sequence 0x4d1d4
10d8e00  0000 0000 0015 5728 0003 0000 0181 0008
10d8e10  0000 1447 0080 0020 0000 0001 0000 0000

Blktrace data is handled by relay, which uses ringbuffers...

I decided to use the following debug patch:

debug patch: poison various kinds of unused relay buffers
---
 kernel/relay.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -735,6 +735,8 @@ size_t relay_switch_subbuf(struct rchan_
 		old_subbuf = buf->subbufs_produced % buf->chan->n_subbufs;
 		buf->padding[old_subbuf] = buf->prev_padding;
 		buf->subbufs_produced++;
+		memset((char *)buf->data + buf->offset, 0x66,
+		       buf->prev_padding);
 		if (buf->dentry)
 			buf->dentry->d_inode->i_size +=
 				buf->chan->subbuf_size -
@@ -767,6 +769,8 @@ size_t relay_switch_subbuf(struct rchan_
 	if (unlikely(length + buf->offset > buf->chan->subbuf_size))
 		goto toobig;
 
+	memset(buf->data, 0x55, buf->chan->subbuf_size);
+
 	return length;
 
 toobig:
@@ -1112,6 +1116,7 @@ static int subbuf_read_actor(size_t read
 		desc->error = -EFAULT;
 		ret = 0;
 	}
+	memset(from, 0x77, ret);
 	desc->arg.data += ret;
 	desc->written += ret;
 	desc->count -= ret;


I found out that the trace data is already corrupted when it is being
copied to user space by copy_to_user() in kernel/relay.c. My 0x55
patterns marking invalidated buffers showed up in user space:

magic    0x65617407
sequence 0x00003baf
time     0x5555555555555555
sector   0x5555555555555555
bytes    0x55555555
action   0x55555555
pid      0x55555555
device   0x55555555
cpu      0x55555555
error    0x5555
pdu_len  0x5555

65617407 00003baf 55555555 55555555 55555555 55555555 55555555 55555555
55555555 55555555 55555555 55555555


Next I added another debug patch to catch poisoned buffers, that is,
stale data prior to copy_to_user().


debug patch: detect relay buffer poisoning when copying data to user
space
---
 kernel/relay.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -1098,6 +1098,45 @@ static size_t relay_file_read_end_pos(st
        return end_pos;
 }

+static inline void hexdump(char *buf, int len, char *descr)
+{
+       int i;
+
+       printk("<----- %s, buffer at %p, length %d, first <=4096 bytes:" ,
+              descr, buf, len);
+       for (i = 0; i < min(len, 4096); i++) {
+               if (i % 4 == 0)
+                       printk(" ");
+               if (i % 32 == 0)
+                       printk("\n");
+               printk("%02x", buf[i]);
+       }
+       printk("----->\n\n");
+}
+
+static inline void * memsearch(char *buf, char c, size_t buf_len, size_t c_len)
+{
+       char *p = buf;
+       int i;
+
+       do {
+               p = memchr(p, c, buf_len - (p - buf));
+               if (!p)
+                       return NULL;
+               for (i = 0; i < c_len - 1; i++, p++) {
+                       if (p >= buf + buf_len)
+                               return NULL;
+                       if (*p != c)
+                               break;
+               }
+               if (i == c_len - 1) {
+                       hexdump(p - (c_len + 32), c_len + 64, "memsearch");
+/*
  *     subbuf_read_actor - read up to one subbuf's worth of data
  */
@@ -1112,6 +1151,12 @@ static int subbuf_read_actor(size_t read

        from = buf->start + read_start;
        ret = avail;
+
+       if (memsearch(from, 0x55, avail, 16)/* ||
+           memsearch(from, 0x66, avail, 8) ||
+           memsearch(from, 0x77, avail, 8)*/)
+               hexdump(from, avail, "relay: found buffer poisoning");
+
        if (copy_to_user(desc->arg.buf, from, avail)) {
                desc->error = -EFAULT;
                ret = 0;                       return (p - c_len);



After some tests with and without detection of buffer poison in kernel
space, I think that the time required by my kernel debug patch to scan
for buffer poison reduces the chances of hitting bad traces in user
space. 

Another observation: when scanning buffers that are about to be copied
to user space, hexdumps of poisoned buffers do not show buffer poison
where it has been found just a split second before. A typical example:

77777777 77777777 77777777 77777777 77777777 77777777 77656174 070001c3
37000001 26a13312 80000000 00003bf9 d0000080 00014100 0700000f 46008000
10000000 00000000 00555555 55555555

The second line should contain a 0x55 pattern. It's gone.

What else do we see.... Scanning backward there are bytes already
(recently?) copied to user space (0x77 pattern). Scanning forward there
is room for more traces (0x55 pattern).


This is my theory:
Timing matters. It's a race caused by improper protection of critical
sections in a producer-consumer scenario. A bug in the bookkeeping
allows a reader to read at a position that is just being written to.

I have got no real evidence. I don't understand yet, how reader-writer
serialisation is implemented in relay.


I use FCP disks attached to a Linux guest on a System z and an internal
tool for I/O workload generation. I have stripped my environment down to
1 disk with 4 paths. Data is written to and read from a device mapper
device. Blktrace is run for the 4 underlying SCSI devices:

blktrace -a issue -a complete -o - /dev/sda /dev/sdu /dev/sdao \
/dev/sdbi | blkiomon -I 100 -b blkiomon.out

I run a recent git kernel and a recent git blktrace. The problem has
also been seen with older code, though.


Any comment is welcome.

Please keep me on to: or cc: since I am not subscribed to linux-kernel.

Thanks,
Martin
